class QuestionAnswer {
  final String question;
  final String answer;
  final String? videoUrl;

  QuestionAnswer({
    required this.question,
    required this.answer,
    required this.videoUrl,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
        question: json['question'],
        answer: json['answer'],
        videoUrl: json['videoUrl']);
  }
}
