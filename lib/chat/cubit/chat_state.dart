part of 'chat_cubit.dart';

enum ChatStatus {
  loading,
  loaded,
  error,
  initial,
}

class ChatState extends Equatable {
  final ConversationSession conversationSession;
  final List<Message> messages;
  final Mood? mood;
  final ChatStatus chatStatus;
  final Failure failure;

  const ChatState({
    required this.conversationSession,
    required this.messages,
    required this.mood,
    required this.chatStatus,
    required this.failure,
  });

  factory ChatState.initial() {
    return ChatState(
      conversationSession: ConversationSession.initial(),
      messages: const [],
      mood: null,
      chatStatus: ChatStatus.initial,
      failure: Failure.empty(),
    );
  }

  @override
  List<Object?> get props => [
        conversationSession,
        messages,
        mood,
        chatStatus,
        failure,
      ];

  ChatState copyWith({
    ConversationSession? conversationSession,
    List<Message>? messages,
    Mood? mood,
    ChatStatus? chatStatus,
    Failure? failure,
  }) {
    return ChatState(
      conversationSession: conversationSession ?? this.conversationSession,
      messages: messages ?? this.messages,
      mood: mood ?? this.mood,
      chatStatus: chatStatus ?? this.chatStatus,
      failure: failure ?? this.failure,
    );
  }
}
