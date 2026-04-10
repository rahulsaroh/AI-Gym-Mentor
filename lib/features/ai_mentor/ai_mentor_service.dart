import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_gym_mentor/core/ai_context_builder.dart';

final aiMentorServiceProvider = Provider<AiMentorService>((ref) {
  final contextBuilder = ref.watch(aiContextBuilderProvider);
  return AiMentorService(contextBuilder);
});

class AiMentorService {
  final AiContextBuilder _contextBuilder;
  late final GenerativeModel _model;

  AiMentorService(this._contextBuilder) {
    // We read the API key passed in via --dart-define=GEMINI_API_KEY
    const apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
    
    // Setting up the persona and behavior
    final systemInstruction = Content.system(
      'You are the AI Gym Mentor, a professional, science-backed fitness coach. '
      'Your goal is to provide concise, actionable, and encouraging advice for workouts, '
      'recovery, and form. Base your recommendations strictly on the user profile and '
      'workout history provided. Be direct and avoid overly verbose responses. '
      'Use the metric/imperial unit preference provided in the context.',
    );

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: systemInstruction,
    );
  }

  /// Starts a persistent chat session initialized with the user's Drift DB context.
  Future<ChatSession> startChatSession() async {
    final contextData = await _contextBuilder.buildGeneralContext();
    
    final initialHistory = [
      Content.text('Here is my current profile and workout context:\n$contextData'),
      Content.model([TextPart('Got it! I have reviewed your profile and recent activity. How can I help you crush your goals today?')])
    ];

    return _model.startChat(history: initialHistory);
  }

  /// Fetches form tips for a specific exercise without needing a full chat history
  Future<String> getFormTips(String exerciseName, String muscleGroup) async {
    final prompt = _contextBuilder.buildExerciseContext(exerciseName, muscleGroup);
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'I am currently unable to fetch form tips for this exercise. Ensure you have network connectivity.';
    } catch (e) {
      return 'Error fetching form tips: $e';
    }
  }

  /// Generates a quick motivational message (e.g. for PRs)
  Future<String> generateMotivationalMessage(String achievement) async {
    final prompt = 'The user just achieved a new milestone: "$achievement". Give a short, high-energy, and professional 1-sentence motivational congratulation.';
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Great job on the new PR! Keep pushing!';
    } catch (e) {
      return 'Great job on the new PR! Keep pushing!';
    }
  }
}
