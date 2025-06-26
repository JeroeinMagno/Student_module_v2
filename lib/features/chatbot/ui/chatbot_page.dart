import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(ChatMessage(
        text: _messageController.text,
        isUser: true,
      ));
      // Add a sample bot response
      _messages.add(ChatMessage(
        text: "I'm here to help! This is a placeholder response. In a real implementation, this would connect to an AI service.",
        isUser: false,
      ));
    });
    
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Assistant',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Chat with AI Assistant',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: _messages.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.smart_toy,
                                          size: 64.sp,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'Hi! I\'m your AI study assistant.',
                                          style: Theme.of(context).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'Ask me questions about your courses, study tips, or career advice!',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.all(16.w),
                                    itemCount: _messages.length,
                                    itemBuilder: (context, index) {
                                      final message = _messages[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: Row(
                                          mainAxisAlignment: message.isUser
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            if (!message.isUser) ...[
                                              CircleAvatar(
                                                radius: 16.r,
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                child: Icon(
                                                  Icons.smart_toy,
                                                  size: 16.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                            ],
                                            Flexible(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 8.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: message.isUser
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Theme.of(context).colorScheme.surfaceVariant,
                                                  borderRadius: BorderRadius.circular(12.r),
                                                ),
                                                child: Text(
                                                  message.text,
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: message.isUser
                                                        ? Colors.white
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (message.isUser) ...[
                                              SizedBox(width: 8.w),
                                              CircleAvatar(
                                                radius: 16.r,
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                child: Icon(
                                                  Icons.person,
                                                  size: 16.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      FloatingActionButton(
                        onPressed: _sendMessage,
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}
