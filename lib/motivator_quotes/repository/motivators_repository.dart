import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hacklegendsa/motivator_quotes/model/motivator.dart';

class MotivatorsRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Motivator>> getMotivators() async {
    final List<Motivator> motivators = [];
    final snapshot = await _firestore.collection('motivators').get();

    for (final motivator in snapshot.docs) {
      if (motivator.exists) {
        motivators.add(Motivator.fromJson(motivator.data()));
      }
    }

    return motivators;
  }
}
