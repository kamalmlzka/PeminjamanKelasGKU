import 'package:cloud_firestore/cloud_firestore.dart';

class FetchUserPinjam {
  static Stream<QuerySnapshot> fetchModelPinjam(String userUid) {
    return FirebaseFirestore.instance
        .collection('bookingUserDetails')
        .doc(userUid)
        .collection('bookings').orderBy("slotKey")
        .snapshots();
  }
}
