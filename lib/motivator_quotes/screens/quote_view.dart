import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hacklegendsa/motivator_quotes/model/motivator.dart';

class QuoteView extends StatefulWidget {
  QuoteView({
    Key? key,
    required this.motivator,
  }) : super(key: key);
  Motivator motivator;
  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  List<String> quotes = [];
  late int currentIndex;
  @override
  void initState() {
    quotes = widget.motivator.quotes;
    quotes.shuffle();
    currentIndex = Random().nextInt(quotes.length - 1);
    super.initState();
  }

  void nextQuote() {
    int newInt = currentIndex + 1;

    if (newInt == quotes.length) {
      setState(() {
        currentIndex = 0;
      });
    } else {
      setState(() {
        currentIndex = newInt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_right,
        ),
        onPressed: () {
          nextQuote();
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topCenter,
            colors: [
              Color(0xffFFEFBA),
              Color(0xffFFFFFF),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          quotes[currentIndex],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
