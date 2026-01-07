import 'package:exam_master_flutter/respositorys/chat_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatView();
}

class ChatMessage {
  bool? isUser = false;
  String message;
  ChatMessage({this.isUser, required this.message});
}

class _ChatView extends ConsumerState<ChatView> {
  String fullResponse = "";
  String conversationId = "";
  String currentResponse = "";
  bool isResponse = false;
  StringBuffer thinkBuffer = StringBuffer(); // 暂存思考过程的垃圾桶
  bool isThinking = true; // 默认假设一开始就在思考 (DeepSeek 等推理模型通常如此)
  List<ChatMessage> storage = [];

  void _scrollToBottom() {
    // 确保在组件构建完成后执行滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent, // 滚到最大距离（也就是底部）
          duration: const Duration(milliseconds: 300), // 动画时长
          curve: Curves.easeOut, // 动画曲线
        );
        // 如果想要瞬间跳到底部，用这个：
        // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void sendUserMessage(String text) {
    // 1. 这里先添加用户自己的气泡到列表...

    // 2. 准备接收 AI 回复

    setState(() {
      fullResponse = "";
      thinkBuffer.clear();
      isThinking = true;
      storage.add(ChatMessage(message: '思考中...', isUser: false));
    }); // 刷新一下，显示一个 Loading 状态

    // 3. 发起请求
    ChatRespository().sendMessageStream(
      query: text,
      conversationId: conversationId.isEmpty ? null : conversationId,

      // 🔥 收到一个字，就刷新一次
      onTextChunk: (chunk) {
        // ----------------------------------------------------
        // 情况 A: 已经思考完了 (最常见的情况)
        // ----------------------------------------------------
        if (!isThinking) {
          setState(() {
            // 直接拼接
            fullResponse += chunk;
            setState(() {
              currentResponse += chunk;
              storage.last.message += chunk;
              isResponse = true;
            });
            _scrollToBottom();
            // 【可选优化】：如果你想隐藏 <think> 标签，可以在这里做正则过滤
            // 但流式传输中做过滤比较复杂，通常建议先全部显示，
            // 或者在显示 Widget (MarkdownWidget) 里做渲染处理
          });
          return;
        }
        // ----------------------------------------------------
        // 情况 B: 还在思考中，或者刚开始
        // ----------------------------------------------------
        thinkBuffer.write(chunk); // 先扔进暂存区，不显示
        String currentBuffer = thinkBuffer.toString();
        // 检查 1: 看看有没有结束标签 </think>
        if (currentBuffer.contains('</think>')) {
          // 找到了！思考结束！
          setState(() {
            // storage.remove(storage.last);
            isThinking = false;
          });

          // ✂️ 裁剪：取 </think> 后面的内容
          List<String> parts = currentBuffer.split('</think>');
          String realContent = parts.last;

          // 如果 split 导致前面还有残余 (比如 <think>...content)，这里 parts.last 就是 content
          // 但要注意：如果 buffer 里压根没有 <think> 开头（比如模型没思考直接回复），
          // 这种逻辑需要额外的防错。但 DeepSeek-R1 通常很规范。

          setState(() {
            fullResponse += realContent; // 把“解禁”后的内容显示出来
          });
          return;
        }

        // 检查 2: 防御性编程
        // 如果暂存区已经很长了(比如50个字)，还没出现 <think>，说明模型根本没在思考
        // 直接把缓冲区的内容全部吐出来，并关闭思考模式
        if (currentBuffer.length > 50 && !currentBuffer.startsWith('<think>')) {
          isThinking = false;
          setState(() {
            fullResponse += currentBuffer;
          });
        }
      },

      // 🔥 收到会话ID，存起来，下次对话用
      onConversationIdReceived: (id) {
        setState(() {
          storage.last.message = '';
        });
        conversationId = id;
      },

      onDone: () {
        print("回答完毕");
        // 这里可以将 fullResponse 存入本地数据库
        setState(() {
          storage.remove(storage.last);
          if (fullResponse.isNotEmpty) {
            storage.add(ChatMessage(message: fullResponse, isUser: false));
          }
          isResponse = false;
        });
      },
    );
  }

  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    storage.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Agent', style: TextStyle(fontSize: 36)),
          centerTitle: false,
        ),
        body: Column(
          children: [
            // 聊天可滚动页面
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: storage.length,
                itemBuilder: (context, index) {
                  return message(
                    context,
                    storage[index].message,
                    isUser: storage[index].isUser,
                  );
                  // isResponse
                  //     ? message(context, currentResponse)
                  //     : SizedBox.shrink(),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _globalKey,
                child: TextFormField(
                  onTap: () => _scrollToBottom(),
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入内容';
                    }
                    return null;
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                    label: Text('输入聊天内容'),
                    suffix: TextButton(
                      onPressed: () => {
                        if (_globalKey.currentState!.validate())
                          {
                            _scrollToBottom(),
                            setState(() {
                              storage.add(
                                ChatMessage(
                                  message: messageController.text,
                                  isUser: true,
                                ),
                              );
                            }),
                            sendUserMessage(messageController.text),
                            messageController.clear(),
                          },
                      },
                      child: Text('发送'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget message(BuildContext context, String message, {bool? isUser = false}) {
  return Container(
    color: isUser == false
        ? Colors.red.shade800.withAlpha(20)
        : Colors.green.shade800.withAlpha(20),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isUser == false
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            isUser == false ? 'Agent' : 'User',
            style: TextStyle().copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Divider(thickness: 1, height: 1),
          SizedBox(height: 8),
          Text(message),
        ],
      ),
    ),
  );
}
