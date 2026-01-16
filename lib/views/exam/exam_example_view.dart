import 'package:exam_master_flutter/models/question_model.dart';
import 'package:exam_master_flutter/views/exam/question_template_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive_ce.dart';

class ExamExampleView extends ConsumerStatefulWidget {
  const ExamExampleView({super.key});
  @override
  ConsumerState<ExamExampleView> createState() => _ExamExampleView();
}

class _ExamExampleView extends ConsumerState<ExamExampleView> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('题目测试页面'),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
        actions: [
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => {quiz.clear()},
            icon: Icon(Icons.clear_all),
          ),
          IconButton.filled(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => {
              quiz.add(data),
              debugPrint('增加数据: $data'),
              debugPrint('一共有${quiz.length}条数据'),
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: quiz.watch(),
        builder: (context, snapshot) {
          final count = quiz.length;
          return quiz.length == 0
              ? Center(child: Text('暂无数据'))
              : ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    debugPrint('第$index个元素');
                    final gData = quiz.getAt(index);
                    if (gData != null) {
                      final Question question = Question.fromMap(gData);
                      return count == 0
                          ? Text('暂无数据')
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: QuestionTemplateView(
                                question: question.question,
                                tag: question.tags,
                                answer: question.answers,
                                question_point: question.point,
                                correct_answer: question.correctAnswer,
                              ),
                            );
                    }
                    return null;
                  },
                );
        },
      ),
    );
  }
}
