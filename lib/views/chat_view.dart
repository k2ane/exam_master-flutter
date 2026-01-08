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
    firstName: '海程问答助手',
    // profileImage: 'https://api.dicebear.com/7.x/bottts/png?seed=ai',
  );

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }

  String currentResponse = '';
  bool isResponse = false;
  bool isThinking = true;

  final chat = ChatRespository();

  Future<void> sendMessage(String text) async {
    // 清空Response
    currentResponse = '';
    String tmp = '';
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
      query: text,
      onTextChunk: ((chunk) {
        // tmp += chunk;
        // debugPrint(tmp);
        // 检查是是否思考完成
        // if (tmp.contains('<think>')) {
        //   isThinking = true;
        //   debugPrint('开始思考');
        //   return;
        // }
        // // 思考完成
        // if (tmp.contains('</think>')) {
        //   isThinking = false;
        //   debugPrint('思考结束');
        //   return;
        // }
        // // 思考中忽略思考部分
        // if (isThinking) {
        //   debugPrint('正在思考中...');
        //   return;
        // }
        // 思考完成进入回答正文
        currentResponse += chunk;
        setState(() {
          _messages.first = ChatMessage(
            user: ai,
            createdAt: DateTime.now(),
            text: currentResponse,
          );
        });
      }),
      onDone: () {
        setState(() {
          isResponse = false;
        });
        debugPrint('输出完成');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海程问答助手')),
      body: DashChat(
        messageOptions: MessageOptions(
          showTime: true,
          marginDifferentAuthor: EdgeInsets.only(top: 16, left: 16, right: 16),
          marginSameAuthor: EdgeInsets.only(top: 16, left: 16, right: 16),
        ),
        inputOptions: InputOptions(
          inputToolbarPadding: EdgeInsets.all(16),
          inputDecoration: InputDecoration(
            label: Text('请输入内容'),
            border: OutlineInputBorder(),
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

          print("发送了: ${m.text}");
        },
        messages: _messages.map((item) {
          return ChatMessage(
            user: item.user,
            createdAt: item.createdAt,
            text: item.text,
          );
        }).toList(),
        // 🔥 AI 场景必备：正在输入动画
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
