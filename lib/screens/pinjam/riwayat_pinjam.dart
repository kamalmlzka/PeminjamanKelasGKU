import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "dart:developer" as dev;
import "/widgets/ddm.dart";
import "/widgets/build_list_builder.dart";

import "/services/fetch_user_pinjam.dart";

class RiwayatPinjam extends StatefulWidget {

  const RiwayatPinjam({super.key});

  @override
  State<RiwayatPinjam> createState() => _RiwayatPinjamState();
}

class _RiwayatPinjamState extends State<RiwayatPinjam> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Riwayat Pinjam',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: StreamBuilder(
            stream: FetchUserPinjam.fetchModelPinjam(uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              var sortedDocs = snapshot.data!.docs.toList()
                ..sort((a, b) {
                  var aDate = DateFormat("dd-MM-yyyy")
                      .parse((a.data() as Map<String, dynamic>)['date']);
                  var bDate = DateFormat("dd-MM-yyyy")
                      .parse((b.data() as Map<String, dynamic>)['date']);
                  return aDate.compareTo(bDate);
                });

              List<DocumentSnapshot> previousBooking = [];
              DateTime today = DateTime.now();
              dev.log(today.toString());

              for (var doc in sortedDocs) {
                DateTime bookingDate =
                DateFormat("dd-MM-yyyy").parse(doc['date']);
                if (!(bookingDate.year == today.year &&
                    bookingDate.month == today.month &&
                    bookingDate.day == today.day) &&
                    !bookingDate.isAfter(today)) {
                  previousBooking.add(doc);
                }
              }
              dev.log(previousBooking.length.toString());

              if (previousBooking.isEmpty) {
                return const Center(
                  child: Text('No Booking available.'),
                );
              }

              return BuildListBuilder(bookings: previousBooking,isDelete: false,uid: uid);
            },
          ),
        ),
      ),
    );
  }
}
