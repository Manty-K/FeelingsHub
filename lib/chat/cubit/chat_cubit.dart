import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hacklegendsa/chat/model/conversation_session.dart';
import 'package:hacklegendsa/chat/model/message.dart';
import 'package:hacklegendsa/chat/model/mood.enum.dart';
import 'package:hacklegendsa/chat/repository/chat_repository.dart';
import 'package:hacklegendsa/common/failure.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.initial());

  final ChatRepository _repository = ChatRepository();

  void connectSomeone({required Mood mood}) async {
    emit(state.copyWith(chatStatus: ChatStatus.loading, mood: mood));
    try {
      final session =
          await _repository.connectSomeone(EnumToString.convertToString(mood));
      emit(
        state.copyWith(
          chatStatus: ChatStatus.loaded,
          conversationSession: session,
        ),
      );
    } catch (e, s) {
      print(e);
      print(s);
      emit(
        state.copyWith(
          chatStatus: ChatStatus.error,
          failure: Failure(e, s),
        ),
      );
    }
  }

  //  void connectSomeone({required Mood mood}) async {
  //   if(mood == Mood.sad){

  //     Uri url = Uri(path: 'https://restapi.punitchoudhary.repl.co/sad/<id-of-user>');
  //     final response = http.put(url)

  //   }else{

  //   }
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> chatStream() {
    return _repository.getChats(state.conversationSession.id);
  }

  void updatedMessages(List<Message> updatedMessages) {
    emit(state.copyWith(messages: updatedMessages));
  }

  void addMessage(String message) {
    final msg = Message(text: message, mood: state.mood!);
    final updatedMessages = [...state.messages, msg];

    _repository.updateConv(state.conversationSession.id!, updatedMessages);
  }

  void deleteChat() {
    _repository.deleteChat(state.conversationSession.id!);
    emit(ChatState.initial());
  }
}
