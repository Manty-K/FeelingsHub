import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/quote.dart';

class RandomQuoteRepository {
  Future<Quote> getRandomQuote() async {
    final url = Uri.https('quoteapi.punitchoudhary.repl.co', '/quote');

    final data = await http.get(url);

    return Quote.fromJson(jsonDecode(data.body));
  }
}
