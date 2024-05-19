import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:developer" as dev;

class InsertModelPinjam {
  static Future<void> addIndividualModelPinjam({
    required String uid,
    required String pinjamId,
    required Map<String, dynamic> bookingData,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookingUserDetails')
          .doc(uid)
          .collection('bookings')
          .doc(pinjamId)
          .set(bookingData);
      dev.log('Data added to Firestore successfully!', name: "Success");
    } catch (error) {
      dev.log(error.toString(), name: "Error");
    }
  }

  static Future<void> addModelPinjam(
      {required String date,required String pinjamId, required Map<String, dynamic> bookingData,
      }) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookingDetails')
          .doc(date)
          .collection('booking')
          .doc(pinjamId)
          .set(bookingData);
      dev.log('Data added to Firestore successfully!', name: "Success");
    } catch (error){
      dev.log(error.toString(), name: "Error");
    }
  }
}
