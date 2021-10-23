import 'package:bloc/bloc.dart';
import '../model/quote.dart';
import '../random_quote_repository.dart';
import 'package:meta/meta.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  RandomQuoteCubit() : super(RandomQuoteInitial()) {
    getQuote();
  }

  final RandomQuoteRepository _repository = RandomQuoteRepository();

  Future<void> getQuote() async {
    emit(RandomQuoteLoading());
    try {
      final quote = await _repository.getRandomQuote();
      emit(RandonQuoteSuccess(quote));
    } catch (e, s) {
      emit(RandomQuoteFailure(e, s));
    }
  }
}
