import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacklegendsa/common_quesions_screen/model/question_answer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'cubit/common_questions_cubit.dart';

class AnswerScreen extends StatefulWidget {
  AnswerScreen({
    Key? key,
    required this.qa,
  }) : super(key: key);

  QuestionAnswer qa;

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  YoutubePlayerController _ytController =
      YoutubePlayerController(initialVideoId: '');

  @override
  void initState() {
    super.initState();
    if (widget.qa.videoUrl != null || widget.qa.videoUrl!.isNotEmpty) {
      _ytController = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(widget.qa.videoUrl!)!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _ytController,
        ),
        builder: (context, player) {
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            widget.qa.question,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 10),
                          if (widget.qa.videoUrl != null ||
                              widget.qa.videoUrl!.isNotEmpty)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: player),
                                SizedBox(height: 10),
                              ],
                            ),
                          SelectableText(
                            widget.qa.answer,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }
}
