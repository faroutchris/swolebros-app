import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/team.dart';

class TeamsService {
  final CollectionReference<Team> _collection;

  TeamsService(this._collection);

  Future<DocumentSnapshot<Team>> getById(String id) {
    return _collection.doc(id).get();
  }
}
