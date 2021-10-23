import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat/cubit/chat_cubit.dart';
import 'common_quesions_screen/cubit/common_questions_cubit.dart';
import 'homescreen/homescreen.dart';
import 'motivator_quotes/cubit/motivators_cubit.dart';
import 'random_quote/cubit/random_quote_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RandomQuoteCubit>(
          create: (context) => RandomQuoteCubit(),
        ),
        BlocProvider<CommonQuestionsCubit>(
          create: (context) => CommonQuestionsCubit(),
        ),
        BlocProvider<MotivatorsCubit>(
          create: (context) => MotivatorsCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: HomeScreen(),
      ),
    );
  }
}
