import 'package:bloc/bloc.dart';
import '../model/question_answer.dart';
import '../repository/common_questions_repository.dart';
import 'package:meta/meta.dart';

part 'common_questions_state.dart';

class CommonQuestionsCubit extends Cubit<CommonQuestionsState> {
  CommonQuestionsCubit() : super(CommonQuestionsInitial()) {
    getQuestionAnswers();
  }

  final CommonQuestionsRepository _repository = CommonQuestionsRepository();

  Future<void> getQuestionAnswers() async {
    emit(CommonQuestionsLoading());
    try {
      final questionAnswers = await _repository.getCommonQuestions();
      emit(CommonQuestionsLoaded(questionAnswers));
    } catch (e, s) {
      emit(CommonQuestionsFailure(e, s));
    }
  }
}
