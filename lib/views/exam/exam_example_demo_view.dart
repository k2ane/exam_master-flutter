import 'dart:math';

import 'package:exam_master_flutter/models/question_model.dart';
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

  final Map<String, dynamic> data = {
    "content": {
      "question": "根据《海关法》及现行税则规定，下列哪些货物属于一般进出口货物？",
      "question_description": "一般进出口货物是指由进出口货物收发货人向海关申报并缴纳相应税费后进出境的货物。",
      "tags": {"单选", "测试题目"},
      "answer": {
        "A": "进口的用于生产制造的原材料",
        "B": "出口的用于国际展览的样品",
        "C": "个人自用且经海关核准的物品",
        "D": "以保税方式进出境的加工贸易原料",
      },
      "question_point": 10,
      "correct_answer": "A",
    },
  };
  final q = [
    '根据《海关法》及现行税则规定，下列哪些货物属于一般进出口货物？',
    '下列关于加工贸易保税监管的描述，哪几项是正确的？',
    '根据《海关总署关于规范加工贸易企业申报程序的公告》（2023年第12号），下列哪项属于加工贸易企业必须向海关提交的申报文件？',
  ];
  final q_d = [
    '一般进出口货物是指由进出口货物收发货人向海关申报并缴纳相应税费后进出境的货物。',
    '加工贸易保税监管涉及海关对保税区内企业加工、装配货物的管理，包括保税料件的使用、结转和核销。',
    '加工贸易企业申报程序涉及与海关监管相关的单证与申报文件。',
  ];

  int startAt = 0;
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    int totalQuestions = quiz.length;
    int randomQ = Random().nextInt(3);
    int randomQD = Random().nextInt(3);
    return Scaffold(
      appBar: AppBar(
        title: Text('题目测试页面'),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
        actions: [
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => {currentIndex = 1, quiz.clear()},
            icon: Icon(Icons.clear_all),
          ),
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              setState(() {
                randomQ = Random().nextInt(3);
                randomQD = Random().nextInt(3);
              });
              final aData = {
                "content": {
                  "question": q[randomQ],
                  "question_description": q_d[randomQD],
                  "tags": {"单选", "测试题目"},
                  "answer": {
                    "A": "进口的用于生产制造的原材料",
                    "B": "出口的用于国际展览的样品",
                    "C": "个人自用且经海关核准的物品",
                    "D": "以保税方式进出境的加工贸易原料",
                  },
                  "question_point": 10,
                  "correct_answer": "A",
                },
              };
              quiz.add(aData);
              debugPrint('增加数据: $aData');
              debugPrint('一共有${quiz.length}条数据');
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: quiz.watch(),
        builder: (context, snapshot) {
          totalQuestions = quiz.length;
          if (totalQuestions > 0 && currentIndex > 0) {
            final gData = quiz.getAt(currentIndex - 1);
            final Question question = Question.fromMap(gData);
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
                        tag: question.tags,
                        answer: question.answers,
                        question_point: question.point,
                        correct_answer: question.correctAnswer,
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
            return Center(child: Text('没有数据.'));
          }
        },
      ),
    );
  }
}
