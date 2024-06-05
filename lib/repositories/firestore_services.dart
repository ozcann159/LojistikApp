import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loadspotter/models/loadPosting.dart';
import 'package:loadspotter/models/offer.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Yük ilanı ekleme
  Future<void> addLoadPosting(LoadPosting loadPosting) {
    return _db.collection('loadPostings').add(loadPosting.toMap());
  }

  // Teklif ekleme
  Future<void> addOffer(Offer offer) {
    return _db.collection('offers').doc(offer.id).set(offer.toMap());
  }

  // Yük ilanlarını getirme
  Stream<List<LoadPosting>> getLoadPostings() {
    return _db.collection('loadPostings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LoadPosting.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Teklifleri getirme
  Stream<List<Offer>> getOffers(String loadPostingId) {
    return _db
        .collection('offers')
        .where('loadPostingId', isEqualTo: loadPostingId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Offer.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> saveDriverData({
    required String certification,
    required String truckType,
    required String license,
    required String carPlate,
  }) async {
    try {
      await _firestore.collection('drivers').add({
        'certification': certification,
        'truckType': truckType,
        'license': license,
        'carPlate': carPlate,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving driver data: $e');
      rethrow;
    }
  }
}