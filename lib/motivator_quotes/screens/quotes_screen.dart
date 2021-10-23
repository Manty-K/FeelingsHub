import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacklegendsa/motivator_quotes/cubit/motivators_cubit.dart';

import 'quote_view.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BlocConsumer<MotivatorsCubit, MotivatorsState>(
            listener: (context, state) {
              if (state is MotivatorsFailure) {
                print(state.exception);
                print(state.stackTrace);
              }
            },
            builder: (context, state) {
              if (state is MotivatorsLoaded) {
                final motivators = state.motivators;
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                    left: 10,
                  ),
                  child: GridView.builder(
                    itemCount: motivators.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      final motivator = motivators[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuoteView(
                                motivator: motivator,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // margin: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          height: 100,
                          decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Color(0xffad5389),
                              //     Color(0xff3c1053),
                              //   ],
                              // ),
                              border: Border.all(
                                  width: 1,
                                  color: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                              .toInt())
                                      .withOpacity(1.0)),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            motivator.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is MotivatorsLoading) {
                return const Center(
                  child: Text(
                    'Getting Motivators',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'Sorry we could get quotes😢',
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
        ],
      ),
    );
  }
}
