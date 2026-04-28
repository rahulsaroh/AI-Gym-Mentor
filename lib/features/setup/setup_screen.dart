import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController(text: '170');
  WeightUnit _selectedUnit = WeightUnit.kg;
  ExperienceLevel _selectedExperience = ExperienceLevel.beginner;
  BiologicalSex _selectedSex = BiologicalSex.male;
  bool _isSaving = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _loadInitialData();
      _initialized = true;
    }
  }

  Future<void> _loadInitialData() async {
    final settings = await ref.read(settingsProvider.future);
    setState(() {
      _nameController.text = settings.userName;
      _heightController.text = settings.height.toString();
      _selectedUnit = settings.weightUnit;
      _selectedExperience = settings.experienceLevel;
      _selectedSex = settings.sex;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == 0) {
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your name')),
        );
        return;
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleComplete();
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleComplete() async {
    setState(() => _isSaving = true);

    try {
      final currentSettings = await ref.read(settingsProvider.future);
      await ref.read(settingsProvider.notifier).updateSettings(
            currentSettings.copyWith(
              userName: _nameController.text.trim(),
              weightUnit: _selectedUnit,
              experienceLevel: _selectedExperience,
              height: double.tryParse(_heightController.text) ?? 170.0,
              sex: _selectedSex,
            ),
          );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasCompletedSetup', true);

      if (mounted) {
        context.go('/app');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving settings: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                children: [
                  _buildProgressDot(0),
                  const SizedBox(width: 8),
                  _buildProgressDot(1),
                ],
              ),
            ),
            
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildBasicInfoPage(theme, colorScheme),
                  _buildPhysicalInfoPage(theme, colorScheme),
                ],
              ),
            ),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton.outlined(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: _isSaving ? null : _nextPage,
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isSaving
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                _currentPage == 0 ? "Next Step" : "Complete Setup",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDot(int index) {
    final isSelected = _currentPage == index;
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6,
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildBasicInfoPage(ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's get started",
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "First, tell us a bit about yourself.",
            style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 32),
          _buildLabel("What's your name?"),
          TextField(
            controller: _nameController,
            decoration: _inputDecoration("e.g. Rahul"),
          ),
          const SizedBox(height: 24),
          _buildLabel("Preferred Unit"),
          _buildUnitSelector(colorScheme),
          const SizedBox(height: 24),
          _buildLabel("Experience Level"),
          ...ExperienceLevel.values.map((exp) => _buildExperienceOption(exp, colorScheme)),
        ],
      ),
    );
  }

  Widget _buildPhysicalInfoPage(ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personalize your experience",
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "This information helps us calculate your Golden Ratio targets and track your progress accurately.",
            style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 32),
          _buildLabel("Your Biological Sex"),
          _buildSexSelector(colorScheme),
          const SizedBox(height: 32),
          _buildLabel("Your Height (cm)"),
          TextField(
            controller: _heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _inputDecoration("170").copyWith(suffixText: 'cm'),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.sparkles, color: colorScheme.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "We'll use this to set your ideal physique targets automatically.",
                    style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildUnitSelector(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: WeightUnit.values.map((unit) {
          final isSelected = _selectedUnit == unit;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedUnit = unit),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : null,
                ),
                child: Text(unit.name.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? colorScheme.onSurface : colorScheme.onSurfaceVariant)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExperienceOption(ExperienceLevel exp, ColorScheme colorScheme) {
    final isSelected = _selectedExperience == exp;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => setState(() => _selectedExperience = exp),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? colorScheme.primary : colorScheme.outlineVariant, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? colorScheme.primary.withOpacity(0.05) : Colors.transparent,
          ),
          child: Text(exp.name[0].toUpperCase() + exp.name.substring(1), style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? colorScheme.primary : colorScheme.onSurface)),
        ),
      ),
    );
  }

  Widget _buildSexSelector(ColorScheme colorScheme) {
    return Row(
      children: BiologicalSex.values.map((sex) {
        final isSelected = _selectedSex == sex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: sex == BiologicalSex.male ? 12 : 0),
            child: InkWell(
              onTap: () => setState(() => _selectedSex = sex),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? colorScheme.primary : colorScheme.outlineVariant, width: 2),
                  borderRadius: BorderRadius.circular(16),
                  color: isSelected ? colorScheme.primary.withOpacity(0.05) : Colors.transparent,
                ),
                child: Column(
                  children: [
                    Icon(sex == BiologicalSex.male ? Icons.male : Icons.female, color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant, size: 32),
                    const SizedBox(height: 8),
                    Text(sex.name[0].toUpperCase() + sex.name.substring(1), style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? colorScheme.primary : colorScheme.onSurface)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
