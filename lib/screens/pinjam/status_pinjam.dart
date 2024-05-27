import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "/screens/home_screen.dart";
import "/widgets/ddm.dart";
import "/widgets/list_builder.dart";
import "dart:developer" as dev;

import "/services/fetch_user_pinjam.dart";

class StatusPinjam extends StatefulWidget {
  const StatusPinjam({super.key});

  @override
  State<StatusPinjam> createState() => _StatusPinjamState();
}

class _StatusPinjamState extends State<StatusPinjam> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  void bookSlotRoute() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Status Pinjam',
      child: SafeArea(
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

            // if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            //   return const Center(
            //     child: Text('No Booking available.'),
            //   );
            // }

            var sortedDocs = snapshot.data!.docs.toList()
              ..sort((a, b) {
                var aDate = DateFormat("dd-MM-yyyy")
                    .parse((a.data() as Map<String, dynamic>)['date']);
                var bDate = DateFormat("dd-MM-yyyy")
                    .parse((b.data() as Map<String, dynamic>)['date']);
                return aDate.compareTo(bDate);
              });

            List<DocumentSnapshot> bookings = [];
            DateTime today = DateTime.now();
            dev.log(today.toString());

            for (var doc in sortedDocs) {
              DateTime bookingDate =
                  DateFormat("dd-MM-yyyy").parse(doc['date']);
              if ((bookingDate.year == today.year &&
                      bookingDate.month == today.month &&
                      bookingDate.day == today.day) ||
                  bookingDate.isAfter(today)) {
                bookings.add(doc);
              }
            }
            dev.log(bookings.length.toString());

            if (bookings.isEmpty) {
              return const Center(
                child: Text('No Booking available.'),
              );
            }

            return ListBuilder(
              bookings: bookings,
              isDelete: true,
              uid: uid,
            );
          },
        ),
      ),
    );
  }
}
