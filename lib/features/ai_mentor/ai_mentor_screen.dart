import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_gym_mentor/features/ai_mentor/ai_mentor_provider.dart';

class AiMentorScreen extends ConsumerStatefulWidget {
  const AiMentorScreen({super.key});

  @override
  ConsumerState<AiMentorScreen> createState() => _AiMentorScreenState();
}

class _AiMentorScreenState extends ConsumerState<AiMentorScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiMentorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<AiMentorState>(aiMentorProvider, (previous, next) {
      if ((previous?.chatHistory.length ?? 0) < next.chatHistory.length || 
          (previous?.isTyping == true && next.isTyping == false)) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber),
            SizedBox(width: 8),
            Text('AI Mentor'),
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (state.isInitializing)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Analyzing your workout history...', 
                           style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else if (state.error != null && state.chatHistory.isEmpty)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      state.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.chatHistory.length,
                  itemBuilder: (context, index) {
                    final message = state.chatHistory[index];
                    final isUser = message.role == 'user';
                    final parts = message.parts;
                    final text = parts.isNotEmpty && parts.first is TextPart 
                        ? (parts.first as TextPart).text 
                        : '';

                    return _MessageBubble(
                      text: text,
                      isUser: isUser,
                    );
                  },
                ),
              ),
            
            if (state.isTyping)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('AI Mentor is typing...', 
                              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                ),
              ),

            // Input Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask for advice, form tips...',
                        hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (val) {
                        _sendMessage();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: state.isInitializing || state.isTyping ? null : _sendMessage,
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

  void _sendMessage() {
    final text = _textController.text;
    if (text.trim().isNotEmpty) {
      _textController.clear();
      ref.read(aiMentorProvider.notifier).sendMessage(text);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _MessageBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.amber,
              child: Icon(Icons.auto_awesome, size: 16, color: Colors.black),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? theme.primaryColor : theme.cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 20),
                ),
                border: isUser ? null : Border.all(color: theme.dividerColor),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 24),
        ],
      ),
    );
  }
}
