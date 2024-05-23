import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:developer" as dev;

class FetchSlots {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<int> getAllottedSlots(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection("slots").doc(uid).get();
      if (documentSnapshot.exists) {
        int slot = documentSnapshot.data()?['slots'] ?? 0;
        return slot;
      } else {
        await _firestore.collection("slots").doc(uid).set({'slots': 4});
        return 4;
      }
    } catch (error) {
      dev.log(error.toString(), name: "Error");
      return 0;
    }
  }
}
