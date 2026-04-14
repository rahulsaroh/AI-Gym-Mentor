import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart' as ent;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ProgressPhotosScreen extends ConsumerStatefulWidget {
  const ProgressPhotosScreen({super.key});

  @override
  ConsumerState<ProgressPhotosScreen> createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends ConsumerState<ProgressPhotosScreen> {
  String _selectedCategory = 'front';
  final List<String> _categories = ['front', 'side', 'back'];

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory(p.join(appDir.path, 'progress_photos'));
      if (!await photosDir.exists()) await photosDir.create();

      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final localFile = await File(image.path).copy(p.join(photosDir.path, fileName));

      final photo = ent.ProgressPhoto(
        id: 0,
        date: DateTime.now(),
        imagePath: localFile.path,
        category: _selectedCategory,
      );

      await ref.read(progressPhotosListProvider.notifier).addPhoto(photo);
    }
  }

  void _showTimelapse() async {
    final allPhotos = await ref.read(progressPhotosListProvider.future);
    final categoryPhotos = allPhotos.where((p) => p.category == _selectedCategory).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (categoryPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add some photos to this category first!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => _TimelapseViewer(photos: categoryPhotos),
    );
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(progressPhotosListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transformation', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.play),
            onPressed: _showTimelapse,
            tooltip: 'Play Timelapse',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat.toUpperCase()),
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: photosAsync.when(
              data: (photos) {
                final filtered = photos.where((p) => p.category == _selectedCategory).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.camera, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text('No photos for this view', style: TextStyle(color: Colors.grey[400])),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final photo = filtered[index];
                    return GestureDetector(
                      onTap: () => _viewPhoto(photo),
                      onLongPress: () => _confirmDelete(photo),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(File(photo.imagePath), fit: BoxFit.cover),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                color: Colors.black45,
                                child: Text(
                                  DateFormat('MMM d').format(photo.date),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: const Icon(LucideIcons.camera),
      ),
    );
  }

  void _viewPhoto(ent.ProgressPhoto photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(File(photo.imagePath)),
            ),
            const SizedBox(height: 16),
            Text(DateFormat('MMMM d, yyyy').format(photo.date), 
                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(ent.ProgressPhoto photo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Photo?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(progressPhotosListProvider.notifier).deletePhoto(photo.id);
              context.pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _TimelapseViewer extends StatefulWidget {
  final List<ent.ProgressPhoto> photos;
  const _TimelapseViewer({required this.photos});

  @override
  State<_TimelapseViewer> createState() => _TimelapseViewerState();
}

class _TimelapseViewerState extends State<_TimelapseViewer> {
  int _currentIndex = 0;
  bool _isPlaying = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_isPlaying) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.photos.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photos[_currentIndex];
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(photo.imagePath), fit: BoxFit.contain),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(DateFormat('MMMM d, yyyy').format(photo.date), 
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(_isPlaying ? LucideIcons.pause : LucideIcons.play, color: Colors.white, size: 32),
                      onPressed: () => setState(() => _isPlaying = !_isPlaying),
                    ),
                    const SizedBox(width: 40),
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.white, size: 32),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / widget.photos.length,
                    backgroundColor: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
