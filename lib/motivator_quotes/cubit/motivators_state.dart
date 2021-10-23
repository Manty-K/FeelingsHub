part of 'motivators_cubit.dart';

@immutable
abstract class MotivatorsState {}

class MotivatorsInitial extends MotivatorsState {}

class MotivatorsLoaded extends MotivatorsState {
  final List<Motivator> motivators;

  MotivatorsLoaded(this.motivators);
}

class MotivatorsLoading extends MotivatorsState {}

class MotivatorsFailure extends MotivatorsState {
  final Object exception;
  final StackTrace stackTrace;
  MotivatorsFailure(this.exception, this.stackTrace);
}
