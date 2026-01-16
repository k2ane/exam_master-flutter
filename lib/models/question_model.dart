class Question {
  final String question;
  final String description;
  final List<String> tags;
  final Map<String, String> answers;
  final int point;
  final String correctAnswer;
  Question({
    required this.question,
    required this.description,
    required this.tags,
    required this.answers,
    required this.point,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<dynamic, dynamic> map) {
    final rowData = map['content'] ?? map;
    final data = Map<String, dynamic>.from(rowData);
    return Question(
      question: data['question']?.toString() ?? '题目缺失',
      description: data['question_description']?.toString() ?? '',
      tags:
          (data['tags'] as Iterable?)?.map((e) => e.toString()).toList() ?? [],
      answers: Map<String, String>.from(data['answer'] ?? {}),
      point: int.tryParse(data['question_point'].toString()) ?? 0,
      correctAnswer: data['correct_answer']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'description': description,
      'tags': tags,
      'answers': answers,
      'point': point,
      'correctAnswer': correctAnswer,
    };
  }
}
