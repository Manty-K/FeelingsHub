part of 'common_questions_cubit.dart';

@immutable
abstract class CommonQuestionsState {}

class CommonQuestionsInitial extends CommonQuestionsState {}

class CommonQuestionsLoaded extends CommonQuestionsState {
  final List<QuestionAnswer> questionAnswers;
  CommonQuestionsLoaded(this.questionAnswers);
}

class CommonQuestionsLoading extends CommonQuestionsState {}

class CommonQuestionsFailure extends CommonQuestionsState {
  final Object exception;
  final StackTrace stackTrace;

  CommonQuestionsFailure(this.exception, this.stackTrace);
}
