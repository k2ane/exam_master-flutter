import 'dart:async';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:exam_master_flutter/respositorys/chat_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatView();
}

class _ChatView extends ConsumerState<ChatView> {
  // 定义用户
  final ChatUser user = ChatUser(id: '1', firstName: 'Kane');
  final ChatUser ai = ChatUser(
    id: '2',
    firstName: '海邦问答助手',
    // profileImage: 'https://api.dicebear.com/7.x/bottts/png?seed=ai',
  );

  final List<ChatMessage> _messages = <ChatMessage>[];

  String currentResponse = '';
  bool isResponse = false;
  bool isThinking = true;

  // 动画定时器
  Timer? _typingTimer;

  // 缓存区：存放 API 返回的最新完整内容
  String _targetText = "";

  // 显示区：界面上实际渲染的内容
  String _currentDisplayText = "";

  @override
  void dispose() {
    _typingTimer?.cancel();
    _messages.clear();
    super.dispose();
  }

  final chat = ChatRespository();

  void _startTypingAnimation() {
    // 如果定时器已经在跑，就别管它，让它继续跑
    if (_typingTimer != null && _typingTimer!.isActive) return;
    _typingTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      // 1. 如果显示的内容 已经追上了 目标内容
      if (_currentDisplayText.length >= _targetText.length) {
        // 这里的逻辑是：如果没有新数据进来，且字都打完了，就暂停一下（不销毁 timer，等待新数据）
        // 或者你可以选择在这里 cancel timer，等收到新 chunk 再重建
        return;
      }
      // 2. 取出下一个要显示的字符
      // 比如当前显示了 10 个字，目标有 15 个字，那我们就取第 11 个字加进去
      final nextChar = _targetText[_currentDisplayText.length];

      setState(() {
        _currentDisplayText += nextChar;
        // 如果是 DashChat
        _messages.first = ChatMessage(
          user: ai,
          createdAt: DateTime.now().subtract(Duration(seconds: 1)),
          text: _currentDisplayText, // 🔥 使用逐字增加的文本
        );
      });
    });
  }

  Future<void> sendMessage(String text) async {
    // 清空Response
    currentResponse = '';
    // 1. 初始化
    _targetText = "";
    _currentDisplayText = "";
    _typingTimer?.cancel(); // 先关掉旧的
    // 初始化
    setState(() {
      isResponse = true;
      _messages.insert(
        0,
        ChatMessage(
          user: ai,
          createdAt: DateTime.now().subtract(Duration(seconds: 1)),
          text: '思考中...',
        ),
      );
    });
    chat.sendMessageStream(
      conversationId: '',
      query: text,
      onTextChunk: ((chunk) {
        setState(() {
          currentResponse += chunk;
          // _messages.first = ChatMessage(
          //   user: ai,
          //   createdAt: DateTime.now(),
          //   text: currentResponse,
          // );
        });
        _targetText += chunk;
        _startTypingAnimation();
      }),
      onDone: () {
        setState(() {
          isResponse = false;
        });
        if (_currentDisplayText == _targetText) {
          _typingTimer!.cancel();
        }
        debugPrint('输出完成');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海邦助手'), centerTitle: false),
      body: DashChat(
        messageOptions: MessageOptions(
          currentUserContainerColor: Theme.of(context).colorScheme.primary,
          currentUserTextColor: Theme.of(context).colorScheme.onPrimary,
          showTime: true,
          marginDifferentAuthor: EdgeInsets.only(top: 16, left: 16, right: 16),
          marginSameAuthor: EdgeInsets.only(top: 16, left: 16, right: 16),
        ),
        inputOptions: InputOptions(
          sendButtonBuilder: (send) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FilledButton(onPressed: send, child: Text('发送')),
            );
          },
          inputToolbarPadding: EdgeInsets.all(16),
          inputDecoration: InputDecoration(
            label: Text('请输入问题'),
            border: UnderlineInputBorder(),
          ),
        ),
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(user: user, createdAt: DateTime.now(), text: m.text),
            );
          });
          sendMessage(m.text);

          debugPrint("用户发送了: ${m.text}");
        },
        messages: _messages.map((item) {
          return ChatMessage(
            user: item.user,
            createdAt: item.createdAt,
            text: item.text,
          );
        }).toList(),
        // 输入动画
        typingUsers: isResponse ? [ai] : [],
        messageListOptions: MessageListOptions(
          typingBuilder: (user) {
            return Container(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TypingIndicator(),
                  Text('${user.firstName} 正在思考中...'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
