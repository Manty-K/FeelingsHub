import 'package:bloc/bloc.dart';
import 'package:hacklegendsa/motivator_quotes/model/motivator.dart';
import 'package:hacklegendsa/motivator_quotes/repository/motivators_repository.dart';
import 'package:meta/meta.dart';

part 'motivators_state.dart';

class MotivatorsCubit extends Cubit<MotivatorsState> {
  MotivatorsCubit() : super(MotivatorsInitial()) {
    getMotivators();
  }
  final MotivatorsRepository _repository = MotivatorsRepository();
  getMotivators() async {
    emit(MotivatorsLoading());
    try {
      final motivators = await _repository.getMotivators();
      emit(MotivatorsLoaded(motivators));
    } catch (e, s) {
      emit(MotivatorsFailure(e, s));
    }
  }
}
