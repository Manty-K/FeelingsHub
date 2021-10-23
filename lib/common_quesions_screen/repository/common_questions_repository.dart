import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/question_answer.dart';

class CommonQuestionsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QuestionAnswer>> getCommonQuestions() async {
    final List<QuestionAnswer> questionAnswers = [];
    final snapshot = await _firestore.collection('common-questions').get();

    for (final qa in snapshot.docs) {
      if (qa.exists) {
        questionAnswers.add(QuestionAnswer.fromJson(qa.data()));
      }
    }

    return questionAnswers;
  }
}
