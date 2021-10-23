import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import 'mood.enum.dart';

class Message extends Equatable {
  final String text;
  final Mood mood;

  const Message({
    required this.text,
    required this.mood,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    Mood m = Mood.sad;
    if (json['mood'] == 'sad') {
      m = Mood.sad;
    } else if (json['mood'] == 'happy') {
      m = Mood.happy;
    }
    return Message(
      text: json['text'],
      mood: m,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'mood': EnumToString.convertToString(mood),
    };
  }

  @override
  List<Object?> get props => [
        text,
        mood,
      ];
}
