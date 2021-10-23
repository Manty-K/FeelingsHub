import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hacklegendsa/chat/model/conversation_session.dart';
import 'package:hacklegendsa/chat/model/message.dart';
import 'package:hacklegendsa/chat/model/mood.enum.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<ConversationSession> connectSomeone(String mood) async {
    final userId = Uuid().v1();

    print('$mood Id : $userId');

    Uri url = Uri.http('172.104.206.215:6969', '/$mood/$userId');

    final response = await http.put(url);

    print('Status Code : ${response.statusCode}');
    print('$mood : ${response.body}');

    if (response.statusCode == 200) {
      final pair = await _getPair(userId, mood);
      return ConversationSession.fromJson(pair);
    } else {
      print('There was some problem');
      throw 'cannot-connect-server';
    }
  }

  Future<Map<String, dynamic>> _getPair(String userId, String mood) async {
    print('Getting pair');
    int attempt = 0;
    Uri url = Uri.http('172.104.206.215:6969', '/pair/$userId');

    http.Response response = await http.get(url);

    print('Status Code : ${response.statusCode}');
    print('Body : ${response.body}');

    if (response.statusCode == 200) {
      print('Success on first run');
      return {'sessionId': response.body};
    }

    while (response.statusCode == 202) {
      stdout.write('Attempt $attempt');
      response = await http.get(url);
      if (response.statusCode == 200) {
        print('\nSuccess after $attempt => ${response.body}');
        return {'sessionId': response.body};
      } else {
        stdout.write(': Failed');
        stdout.write('\n');
      }
      if (attempt == 10) {
        Uri removeUrl =
            Uri.http('172.104.206.215:6969', '$mood/remove/$userId');
        http.Response removeResponse = await http.get(removeUrl);

        print(
            'Remove response => ${removeResponse.statusCode}  :${removeResponse.body}');

        throw 'Timeout';
      }
      await Future.delayed(Duration(seconds: 1));
      attempt++;
    }
    return {
      'This should not run': 'Ever',
    };
  }
  // Future<ConversationSession> connectWithSomeone(Mood mood) async {
  //   final userId = const Uuid().v1();

  //   final sessionMap = _createSession(userId, mood);

  //   final session = ConversationSession.fromJson(sessionMap);

  //   await _firestore.collection('conversations').doc(session.id).set({
  //     'chat': [
  //       {'mood': 'sad', 'text': 'I am sad'},
  //       {'mood': 'happy', 'text': 'I am happy'}
  //     ]
  //   });

  //   return session;
  // }

  // Future<ConversationSession> connectWithSomeone(Mood mood) async {
  //   final userId = const Uuid().v1();

  //   final sessionMap = await _createSession(userId, mood);

  //   if (sessionMap == null) {
  //     throw 'session-not-found';
  //   }

  //   final session = ConversationSession.fromJson(sessionMap);

  //   await _firestore.collection('conversations').doc(session.id).set({
  //     'chat': [
  //       {'mood': 'sad', 'text': 'I am sad'},
  //       {'mood': 'happy', 'text': 'I am happy'}
  //     ]
  //   });

  //   return session;
  // }

  ///server emulation
  // Future<Map<String, dynamic>?> _createSession(String userId, Mood mood) async {
  //   int attempt = 5;

  //   late http.Response pairResponse;

  //   if (mood == Mood.sad) {
  //     Uri url = Uri.http('172.104.206.215:6969', 'sad/$userId');

  //     final response = await http.put(url);

  //     if (response.statusCode == 200) {
  //       Uri pairUrl = Uri.http('172.104.206.215:6969', 'pair/$userId');

  //       pairResponse = await http.get(pairUrl);

  //       while (pairResponse.statusCode != 200) {
  //         pairResponse = await http.get(pairUrl);

  //         if (pairResponse.statusCode == 200) {
  //           return {
  //             'sessionId': pairResponse.body,
  //           };
  //         }

  //         if (attempt > 1) {
  //           attempt--;
  //         } else {
  //           throw 'pair not found';
  //         }
  //         await Future.delayed(
  //           const Duration(seconds: 1),
  //         );
  //       }
  //     }
  //   } else {
  //     Uri url = Uri.http('172.104.206.215:6969', 'happy/$userId');

  //     final response = await http.put(url);

  //     if (response.statusCode == 200) {
  //       Uri pairUrl2 = Uri.http('172.104.206.215:6969', 'pair/$userId');
  //       pairResponse = await http.get(pairUrl2);
  //       while (pairResponse.statusCode != 200) {
  //         pairResponse = await http.get(pairUrl2);

  //         if (pairResponse.statusCode == 200) {
  //           return {
  //             'sessionId': pairResponse.body,
  //           };
  //         }

  //         if (attempt > 1) {
  //           attempt--;
  //         } else {
  //           throw 'pair not found';
  //         }
  //         await Future.delayed(
  //           const Duration(seconds: 1),
  //         );
  //       }
  //     }
  //   }
  // }

  Future<void> updateConv(String sessionId, List<Message> updatedConv) async {
    final List<Map<String, dynamic>> msgs = [];

    for (final msg in updatedConv) {
      msgs.add(msg.toJson());
    }
    await _firestore.collection('conversations').doc(sessionId).set({
      'chat': msgs,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChats(String? sessionId) {
    final snapStream =
        _firestore.collection('conversations').doc(sessionId).snapshots();
    return snapStream;
  }

  void deleteChat(String sessionId) async {
    await _firestore.collection('conversations').doc(sessionId).delete();
  }
}
