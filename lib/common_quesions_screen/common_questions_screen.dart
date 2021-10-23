import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'answer_screen.dart';

import 'cubit/common_questions_cubit.dart';

class CommonQuestionsScreen extends StatelessWidget {
  const CommonQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
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
          ),
          SafeArea(
            child: BlocConsumer<CommonQuestionsCubit, CommonQuestionsState>(
              listener: (context, state) {
                if (state is CommonQuestionsFailure) {
                  print(state.exception);
                  print(state.stackTrace);
                }
              },
              builder: (context, state) {
                if (state is CommonQuestionsLoaded) {
                  final questionAnswers = state.questionAnswers;
                  return ListView.separated(
                    itemCount: questionAnswers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final qa = questionAnswers[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnswerScreen(
                                qa: qa,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            qa.question,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  );
                } else if (state is CommonQuestionsLoading) {
                  return Center(
                    child: Text(
                      'Getting questions...',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'We were unable to get questions',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
