part of 'random_quote_cubit.dart';

@immutable
abstract class RandomQuoteState {}

class RandomQuoteInitial extends RandomQuoteState {}

class RandonQuoteSuccess extends RandomQuoteState {
  final Quote quote;

  RandonQuoteSuccess(this.quote);
}

class RandomQuoteFailure extends RandomQuoteState {
  final Object exception;
  final StackTrace stackTrace;

  RandomQuoteFailure(this.exception, this.stackTrace);
}

class RandomQuoteLoading extends RandomQuoteState {}
