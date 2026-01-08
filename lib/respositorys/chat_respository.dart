import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ChatRespository {
  // API key
  final String apiKey = 'app-7vjpim82Ng4DKKuoFWJ2q2fU';
  // API 地址
  final String baseUrl = 'http://localhost/v1';
  // 流式消息
  /// 发送流式消息
  /// [query]: 用户输入的问题
  /// [conversationId]: 会话ID，传 null 代表开启新会话，后续传入可保持上下文
  /// [onChunk]: 回调函数，每收到一个字都会触发，用于更新 UI
  /// [onDone]: 回答完成时的回调
  // 设置 Header
  Future<void> sendMessageStream({
    required String query,
    String? conversationId,
    required Function(String chunk) onTextChunk, // 收到文本片段回调
    Function(String conversationId)? onConversationIdReceived, // 收到会话ID回调
    Function()? onDone, // 结束回调
  }) async {
    final url = Uri.parse('$baseUrl/chat-messages');
    final request = http.Request('POST', url);

    // 设置Header
    // 设置 Header
    request.headers.addAll({
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    });

    // 设置 Body
    request.body = jsonEncode({
      "inputs": {}, // 如果你的 Dify 应用有变量，在这里填
      "query": query,
      "response_mode": "streaming", // 🔥 关键：必须是 streaming
      "conversation_id": conversationId ?? "",
      "user": "app-user-id", // 区分不同用户的标识
    });
    try {
      final response = await http.Client().send(request);

      // 监听数据流
      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            (String line) {
              // 1. 过滤掉空行和非数据行 (比如 event: ping)
              if (line.isEmpty || !line.startsWith('data: ')) return;

              // 2. 提取 JSON 字符串 (去掉 'data: ' 前缀)
              final jsonStr = line.substring(6);
              // debugPrint(jsonStr);
              try {
                final Map<String, dynamic> data = jsonDecode(jsonStr);
                final String event = data['event'];

                // ------------------------------------------------------
                // 🔥 核心逻辑：根据你的日志进行过滤
                // ------------------------------------------------------

                // 情况 A: 真正的对话内容 (对应你日志里的 event: message)
                if (event == 'message' || event == 'text_chunk') {
                  final String answer = data['answer'] ?? '';
                  // debugPrint(answer);
                  // 回调给 UI，这里就是 "嗯"、"，" 这些字
                  if (answer.isNotEmpty) {
                    onTextChunk(answer);
                  }

                  // 保存会话ID (通常在第一条消息里就会带)
                  if (data.containsKey('conversation_id') &&
                      data['conversation_id'] != null) {
                    if (onConversationIdReceived != null) {
                      onConversationIdReceived(data['conversation_id']);
                    }
                  }
                }
                // 情况 B: 工作流开始/结束 (node_started, node_finished)
                // 你的日志里有很多这种，直接忽略，不处理即可
                else if (event == 'workflow_started' ||
                    event == 'node_started' ||
                    event == 'node_finished') {
                  // Do nothing，不要干扰 UI
                }
                // 情况 C: 整个回答结束
                else if (event == 'message_end' ||
                    event == 'workflow_finished') {
                  // 可以在这里处理结束逻辑
                }
              } catch (e) {
                print("解析当前行 JSON 失败: $e");
              }
            },
            onDone: () {
              if (onDone != null) onDone();
            },
            onError: (e) {
              print("流式连接发生错误: $e");
            },
          );
    } catch (e) {
      print("请求发送失败: $e");
    }
  }
}
