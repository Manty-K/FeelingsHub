import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hacklegendsa/chat/cubit/chat_cubit.dart';
import 'package:hacklegendsa/chat/model/message.dart';
import 'package:hacklegendsa/chat/model/message_owner.enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacklegendsa/chat/model/mood.enum.dart';
import 'package:hacklegendsa/chat/screen/widgets/chat_boc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();

  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode(canRequestFocus: true);

  String vall = '';

  List<Message> convertMessages(Map<String, dynamic>? data) {
    List<Message> messages = [];
    if (data == null) {
      return [];
    }

    final list =
        (data['chat'] as List).map((e) => Message.fromJson(e)).toList();

    for (final msg in list) {
      messages.add(msg);
    }

    return messages;
  }

  void scrollBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state.chatStatus == ChatStatus.error) {
            print(state.failure.exception);
            print(state.failure.stackTrace);
          }
        },
        builder: (context, state) {
          if (state.chatStatus == ChatStatus.loaded) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
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
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: context.read<ChatCubit>().chatStream(),
                    builder: (context, snapshot) {
                      print('This  ${snapshot.data?.data()}');
                      final mes = convertMessages(snapshot.data?.data());
                      context.read<ChatCubit>().updatedMessages(mes);
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: mes
                                .map((e) => ChatBox(
                                      text: e.text,
                                      messageOwner: e.mood ==
                                              context
                                                  .read<ChatCubit>()
                                                  .state
                                                  .mood
                                          ? MessageOwner.sender
                                          : MessageOwner.receiver,
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    }),
                Column(
                  children: [
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextFormField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          autocorrect: true,
                          enableIMEPersonalizedLearning: true,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.go,
                          textCapitalization: TextCapitalization.sentences,
                          onEditingComplete: () {
                            print('fdsf');
                          },
                          onSaved: (ss) {
                            print('save');
                          },
                          onFieldSubmitted: (val) {
                            // setState(() {
                            //   _textEditingController.value =
                            //       TextEditingValue(
                            //           text: _textEditingController.text +
                            //               '\n');
                            //   vall = _textEditingController.text;
                            // });
                            print('field submit');

                            // if (val.trim().isNotEmpty) {
                            _textEditingController.clear();
                            context.read<ChatCubit>().addMessage(val);
                            scrollBottom();
                            // }
                            //_focusNode.requestFocus();
                          },
                        ),
                      ),
                    ),
                    // EmojiPicker(onEmojiSelected: (em, asa) {})
                  ],
                )
              ],
            );
          } else if (state.chatStatus == ChatStatus.loading) {
            return Center(
              child: Text(
                context.read<ChatCubit>().state.mood == Mood.sad
                    ? 'Don\'t worry we are with you 🙂'
                    : 'Thank You for being a helping hand...🙏',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else if (state.chatStatus == ChatStatus.error) {
            return Center(
              child: Text(
                'Problem Occured',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Center(
              child: Text('Initial'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.unfocus();
    _textEditingController.dispose();
    _focusNode.dispose();
  }
}
