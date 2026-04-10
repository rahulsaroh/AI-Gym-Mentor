import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_gym_mentor/features/ai_mentor/ai_mentor_service.dart';

class AiMentorState {
  final ChatSession? session;
  final List<Content> chatHistory;
  final bool isInitializing;
  final bool isTyping;
  final String? error;

  AiMentorState({
    this.session,
    this.chatHistory = const [],
    this.isInitializing = true,
    this.isTyping = false,
    this.error,
  });

  AiMentorState copyWith({
    ChatSession? session,
    List<Content>? chatHistory,
    bool? isInitializing,
    bool? isTyping,
    String? error,
  }) {
    return AiMentorState(
      session: session ?? this.session,
      chatHistory: chatHistory ?? this.chatHistory,
      isInitializing: isInitializing ?? this.isInitializing,
      isTyping: isTyping ?? this.isTyping,
      error: error, // Can be null to clear
    );
  }
}

class AiMentorNotifier extends StateNotifier<AiMentorState> {
  final AiMentorService _service;

  AiMentorNotifier(this._service) : super(AiMentorState()) {
    _initChat();
  }

  Future<void> _initChat() async {
    try {
      final session = await _service.startChatSession();
      // The session history initially contains the context and the AI's first greeting.
      // We only want to display the visual greeting, not the hidden context prompt.
      final visualHistory = session.history.toList();
      
      // Remove the injected context prompt from UI visibility to keep it clean
      if (visualHistory.isNotEmpty && visualHistory.first.role == 'user') {
        visualHistory.removeAt(0); 
      }

      state = state.copyWith(
        session: session,
        chatHistory: visualHistory,
        isInitializing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isInitializing: false,
        error: 'Failed to initialize AI Mentor. Check network and API Key.',
      );
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.session == null) return;

    final userContent = Content.text(text);
    
    // Optimistically add user message and switch to typing state
    state = state.copyWith(
      chatHistory: [...state.chatHistory, userContent],
      isTyping: true,
      error: null,
    );

    try {
      final responseStream = state.session!.sendMessageStream(userContent);
      
      // Create a placeholder for the model's response
      final modelContent = Content.model([TextPart('')]);
      state = state.copyWith(
        chatHistory: [...state.chatHistory, modelContent],
      );

      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          _updateLastMessage(chunk.text!);
        }
      }
      
      state = state.copyWith(isTyping: false);
    } catch (e) {
      state = state.copyWith(
        isTyping: false,
        error: 'Failed to send message. Please try again.',
      );
    }
  }

  void _updateLastMessage(String chunkText) {
    if (state.chatHistory.isEmpty) return;
    
    final history = List<Content>.from(state.chatHistory);
    final lastMessage = history.last;
    
    if (lastMessage.role == 'model') {
      final currentParts = lastMessage.parts.toList();
      if (currentParts.isNotEmpty && currentParts.first is TextPart) {
        final existingText = (currentParts.first as TextPart).text;
        final newText = existingText + chunkText;
        history[history.length - 1] = Content.model([TextPart(newText)]);
        
        state = state.copyWith(chatHistory: history);
      }
    }
  }
}

final aiMentorProvider = StateNotifierProvider<AiMentorNotifier, AiMentorState>((ref) {
  final service = ref.watch(aiMentorServiceProvider);
  return AiMentorNotifier(service);
});
