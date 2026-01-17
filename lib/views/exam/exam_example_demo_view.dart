import 'package:exam_master_flutter/models/ai_question_model.dart';
import 'package:exam_master_flutter/models/question_model.dart';
import 'package:exam_master_flutter/providers/ai_question_provider.dart';
import 'package:exam_master_flutter/views/exam/question_template_view.dart';
import 'package:exam_master_flutter/views/widgets/linear_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive_ce.dart';

class ExamExampleDemoView extends ConsumerStatefulWidget {
  const ExamExampleDemoView({super.key});
  @override
  ConsumerState<ExamExampleDemoView> createState() => _ExamExampleDemoView();
}

class _ExamExampleDemoView extends ConsumerState<ExamExampleDemoView> {
  final quiz = Hive.box('quiz');
  int startAt = 0;
  int currentIndex = 1;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final aiQuestion = ref.read(aiQuestionProvider);
    int totalQuestions = quiz.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('题目测试页面'),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
        actions: [
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: isLoading
                ? null
                : () => {
                    currentIndex = 1,
                    quiz.clear(),
                    debugPrint('一共有${quiz.length}条数据'),
                  },
            icon: Icon(Icons.clear_all),
          ),
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final response = await aiQuestion.getAiQuestions(
                      1,
                      '中国海关进出口知识',
                    );
                    quiz.add(response.toJson());
                    // await Future.delayed(Duration(seconds: 3));
                    setState(() {
                      isLoading = false;
                    });
                    debugPrint('获取到的内容: $response');
                    debugPrint('一共有${quiz.length}条数据');
                  },
            icon: isLoading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(),
                  )
                : Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: quiz.watch(),
        builder: (context, snapshot) {
          totalQuestions = quiz.length;
          if (totalQuestions > 0 && currentIndex > 0) {
            final gData = quiz.getAt(currentIndex - 1);
            final AiQuestionModel question = AiQuestionModel.fromMap(gData);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 24.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: LinearProgressIndicatorWidget(
                          progress: (currentIndex / totalQuestions),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      QuestionTemplateView(
                        question: question.question,
                        type: question.type,
                        options: question.options,
                        answer: question.answer,
                        explanation: question.explanation,
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: currentIndex == 1
                                ? null
                                : () => {
                                    setState(() {
                                      totalQuestions = quiz.length;
                                      if (currentIndex > 1) {
                                        currentIndex -= 1;
                                        debugPrint('现在处于第$currentIndex道题');
                                      }
                                    }),
                                    debugPrint(
                                      '这是第$currentIndex/$totalQuestions道题',
                                    ),
                                  },
                            child: Text('上一题'),
                          ),
                          Text('第$currentIndex/$totalQuestions道题'),
                          ElevatedButton(
                            onPressed: currentIndex == totalQuestions
                                ? null
                                : () => {
                                    setState(() {
                                      totalQuestions = quiz.length;
                                      if (currentIndex < totalQuestions) {
                                        currentIndex += 1;
                                        debugPrint('现在处于第$currentIndex道题');
                                      }
                                    }),
                                    debugPrint(
                                      '这是第$currentIndex/$totalQuestions道题',
                                    ),
                                  },
                            child: Text('下一题'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(height: 16),
                        Text('正在生成题目'),
                      ],
                    ),
                  )
                : Center(child: Text('没有数据.'));
          }
        },
      ),
    );
  }
}
