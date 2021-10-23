import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacklegendsa/chat/cubit/chat_cubit.dart';
import 'package:hacklegendsa/chat/model/mood.enum.dart';
import 'package:hacklegendsa/chat/screen/chat_screen.dart';
import 'package:hacklegendsa/motivator_quotes/screens/quotes_screen.dart';
import 'package:lottie/lottie.dart';
import '../common_quesions_screen/common_questions_screen.dart';
import '../random_quote/cubit/random_quote_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Spacer(),
            /*
            Text('Post of the day'),
            Container(
              color: Colors.white,
              child: Text('This will be updated everyday by admin'),
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    context.read<ChatCubit>().connectSomeone(mood: Mood.sad);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );

                    context.read<ChatCubit>().deleteChat();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey,
                    child: Text('I am feeling sad'),
                    alignment: Alignment.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<ChatCubit>().connectSomeone(mood: Mood.happy);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.yellow,
                    child: Text(
                      'I am feeling cheerful',
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            */
            Text(
              'How are you feeling today?',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      context.read<ChatCubit>().connectSomeone(mood: Mood.sad);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ),
                      );
                      context.read<ChatCubit>().deleteChat();
                    },
                    child: SizedBox(
                      //height: 100,
                      //width: 100,
                      child: Lottie.asset(
                        'assets/grieved.json',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      context
                          .read<ChatCubit>()
                          .connectSomeone(mood: Mood.happy);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ),
                      );
                      context.read<ChatCubit>().deleteChat();
                    },
                    child: SizedBox(
                      // height: 100,
                      // width: 100,
                      child: Lottie.asset(
                        'assets/happy.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'I\'m Low\nLet\'s Talk',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'I\'m Happy\nI\'ll Cheer',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Spacer(),
            BlocConsumer<RandomQuoteCubit, RandomQuoteState>(
              listener: (context, state) {
                if (state is RandomQuoteFailure) {
                  print(state.exception);
                  print(state.stackTrace);
                }
              },
              builder: (context, state) {
                if (state is RandonQuoteSuccess) {
                  return Text(
                    '\"${state.quote.quote}\" - ${state.quote.author}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                    textAlign: TextAlign.center,
                  );
                } else if (state is RandomQuoteLoading) {
                  return Text(
                    'Find quote for you...',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                    textAlign: TextAlign.center,
                  );
                } else if (state is RandomQuoteFailure) {
                  return Text('Have a nice day');
                }
                return Text('intial');
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                myButton('Get Answers', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommonQuestionsScreen(),
                    ),
                  );
                }),
                myButton('Motivators', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuotesScreen(),
                    ),
                  );
                }),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget myButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: myBoxDecoration(), //             <--- BoxDecoration here
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1), borderRadius: BorderRadius.circular(10));
  }
}
