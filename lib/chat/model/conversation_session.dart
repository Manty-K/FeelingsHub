import 'package:equatable/equatable.dart';

class ConversationSession extends Equatable {
  final String? id;
  //final String? sadId;
  //final String? happyId;

  const ConversationSession({
    required this.id,
    //  required this.sadId,
    //  required this.happyId,
  });

  factory ConversationSession.initial() {
    return const ConversationSession(
      id: null,
      //  sadId: null,
      //  happyId: null,
    );
  }

  factory ConversationSession.fromJson(Map<String, dynamic> json) {
    return ConversationSession(
      id: json['sessionId'],
      // sadId: json['sadId'],
      //  happyId: json['happyId'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        //  sadId,
        //  happyId,
      ];
}
