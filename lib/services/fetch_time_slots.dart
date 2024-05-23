import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

class FetchTimeSlots {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, bool>> fetchTimeSlots(String date, String ruang) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("slotJadwal")
        .doc(date)
        .collection("jadwal")
        .doc(ruang)
        .get();
        
    Map<String, bool> timeSlots = {};

    if (documentSnapshot.exists) {
      timeSlots = Map<String, bool>.from(documentSnapshot.data() as Map);
    } else {
      dev.log("No Slots Found, creating default slots", name: "Info");
      await createDefaultTimeSlots(date, ruang);
      documentSnapshot = await _firestore
          .collection("slotJadwal")
          .doc(date)
          .collection("jadwal")
          .doc(ruang)
          .get();
      if (documentSnapshot.exists) {
        timeSlots = Map<String, bool>.from(documentSnapshot.data() as Map);
      }
    }

    return timeSlots;
  }

  static Future<void> createDefaultTimeSlots(String date, String ruang) async {
    Map<String, bool> defaultSlots = {
      "08:30AM": true,
      "09:15AM": true,
      "10:00AM": true,
      "10:55AM": true,
      "11:40AM": true,
      "01:30PM": true,
      "02:15PM": true,
      "03:00PM": true,
      "03:45PM": true
    };

    DocumentReference documentReference = _firestore
        .collection("slotJadwal")
        .doc(date)
        .collection("jadwal")
        .doc(ruang);

    await documentReference.set(defaultSlots);
  }
}