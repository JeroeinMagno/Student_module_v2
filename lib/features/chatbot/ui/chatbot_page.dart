import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/chat_message.dart';
import 'widgets/widgets.dart';

/// Main Chatbot Page for AI Assistant interaction
/// This is the navigation entry point for the chatbot feature
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
            const ChatbotHeader(),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ChatContainer(messages: _messages),
                  ),
                  SizedBox(height: 16.h),
                  ChatInput(
                    controller: _messageController,
                    onSend: _sendMessage,
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
