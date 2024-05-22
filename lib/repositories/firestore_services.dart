import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loadspotter/models/loadPosting.dart';
import 'package:loadspotter/models/offer.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Yük ilanı ekleme
  Future<void> addLoadPosting(LoadPosting loadPosting) {
    return _db.collection('loadPostings').doc(loadPosting.id).set(loadPosting.toMap());
  }

  // Teklif ekleme
  Future<void> addOffer(Offer offer) {
    return _db.collection('offers').doc(offer.id).set(offer.toMap());
  }

  // Yük ilanlarını getirme
  Stream<List<LoadPosting>> getLoadPostings() {
    return _db.collection('loadPostings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => LoadPosting.fromMap(doc.data())).toList();
    });
  }

  // Teklifleri getirme
  Stream<List<Offer>> getOffers(String loadPostingId) {
    return _db.collection('offers').where('loadPostingId', isEqualTo: loadPostingId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Offer.fromMap(doc.data())).toList();
    });
  }
}
