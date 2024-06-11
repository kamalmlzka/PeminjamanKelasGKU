import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:intl/intl.dart";
import "/main.dart";
import "/models/gku_list_data.dart";
import "verify_screen.dart";
import "/services/fetch_slots.dart";
import "/services/fetch_user_pinjam.dart";
import "/services/update_time_slots.dart";
import "/services/generate/generate_time_key.dart";
import "/services/generate/generate_token.dart";
import "/services/generate/generate_week.dart";
import "dart:developer" as dev;

import "/models/model_pinjam.dart";
import "/services/fetch_time_slots.dart";
import "/services/fetch_user_name.dart";
import "/services/fetch_user_token.dart";
import "/services/insert_booking_details.dart";
import "/widgets/ddm.dart";
import "/widgets/button.dart";
import "/widgets/build_slots.dart";
import "/widgets/text_form.dart";

class PinjamRuangan extends StatefulWidget {
  final GkuListData? gkuData;
  const PinjamRuangan({required this.gkuData, super.key});

  @override
  State<PinjamRuangan> createState() => _PinjamRuanganState();
}

class _PinjamRuanganState extends State<PinjamRuangan> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late TextEditingController idPinjam;
  late TextEditingController tokenNumber;
  late TextEditingController name;
  late TextEditingController kodeRuangan;
  late int slotCount;
  late String pinjamId = "";
  late String kodeRuang;
  late Map<String, bool> timeSlots = <String, bool>{};
  TextEditingController date = TextEditingController();
  List<String> selectedSlots = [];
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  String get ruang => kodeRuang;

  @override
  void initState() {
    super.initState();
    slotCount = 0;
    idPinjam = TextEditingController();
    tokenNumber = TextEditingController();
    name = TextEditingController();
    kodeRuangan = TextEditingController();
    pinjamId = generateToken();
    kodeRuang = widget.gkuData?.titleTxt ?? "";
    dev.log(pinjamId, name: "Ticket");

    // ESSENTIALS
    _getSlots(uid).then((value) => slotCount = value);
    _displayDetails();
  }

  void _verifyDetails() {
    dev.log(tokenNumber.text, name: "Token Number");
    dev.log(name.text, name: "Nama");
    dev.log(kodeRuangan.text, name: "Kode Ruangan");
    dev.log(selectedSlots.toString(), name: "Slots");
    dev.log(date.text, name: "Date");

    FetchUserPinjam.fetchModelPinjam(uid).listen((snapshot) {
      checkConditions(snapshot);
    });
  }

  void checkConditions(QuerySnapshot snapshot) {
    if (_formKey.currentState!.validate() && selectedSlots.isNotEmpty) {
      if (snapshot.docs.isEmpty) {
        dev.log("SUBMITTING");
        performSubmission();
      } else {
        String currentWeek = getWeekNumber(date.text);
        List<QueryDocumentSnapshot> filteredSnapshots =
            snapshot.docs.where((doc) => doc['week'] == currentWeek).toList();

        dev.log(slotCount.toString(), name: "Slots");

        if (filteredSnapshots.isEmpty) {
          dev.log("filteredsnapsot empty");
          performSubmission();
        } else if (filteredSnapshots.length == slotCount) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Limit Reached For this Week")));
        } else {
          int bookedSlots = filteredSnapshots.length;
          int slotCounter = 0;
          for (int i = 0; i < bookedSlots; i++) {
            int slotsLength = filteredSnapshots[i]['slots'].length;
            slotCounter += slotsLength;
          }
          dev.log(slotCounter.toString(), name: "From Counter");
          if (slotCounter <= slotCount) {
            dev.log(selectedSlots.length.toString(),
                name: "SLOT LENGTH FROM FINAL");
            if (((slotCount - slotCounter) >= selectedSlots.length)) {
              dev.log("$slotCounter, $slotCount, ${selectedSlots.length}");
              if (selectedSlots.length <= slotCount - slotCounter) {
                performSubmission();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Remaining Slots available for this week is ${slotCount - slotCounter}")));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Remaining Slots available for this week is ${slotCount - slotCounter}")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Limit Reached For this Week")));
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pilih Jadwal Terlebih Dahulu")));
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pinjamId',
      'pinjamName',
      channelDescription: 'pinjamDescription',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Peminjaman Berhasil',
      'Peminjaman anda telah berhasil!',
      platformChannelSpecifics,
    );
  }

  void performSubmission() async {
    setState(() {
      _isSubmitting = true;
    });

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    ModelPinjam modelPinjam = ModelPinjam(
      pinjamId: pinjamId,
      tokenNumber: tokenNumber.text,
      name: name.text,
      week: getWeekNumber(date.text),
      kodeRuangan: kodeRuangan.text,
      date: date.text,
      slots: selectedSlots,
      slotKey: TimeKey.returnTimeKey(selectedSlots[0])!,
    );

    final String uid = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> bookingData = modelPinjam.getModelPinjam();

    InsertModelPinjam.addIndividualModelPinjam(
        uid: uid, bookingData: bookingData, pinjamId: pinjamId);
    InsertModelPinjam.addModelPinjam(
        date: date.text, pinjamId: pinjamId, bookingData: bookingData);

    DateTime myDate = DateFormat("dd-MM-yyyy").parse(date.text);
    updateTimeSlots(
        DateFormat('yyyy-MM-dd').format(myDate), selectedSlots, ruang);

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Booked Successfully")));

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return VerifyScreen(modelPinjam: modelPinjam);
      },
    ), (route) => false);

    await _showNotification();

    setState(() {
      _isSubmitting = false;
    });
  }

  Future<void> fetchTimeSlots(String date, String ruang) async {
    setState(() {
      timeSlots = {};
    });
    timeSlots = await FetchTimeSlots.fetchTimeSlots(date, ruang);
    setState(() {});
  }

  Future<void> updateTimeSlots(
      String date, List<String> selectedSlots, String ruang) async {
    setState(() async {
      await UpdateTimeSlots.insertSlots(date, selectedSlots, false, ruang);
    });
  }

  void _selectSlots(String slot) {
    setState(() {
      if (selectedSlots.contains(slot)) {
        selectedSlots.remove(slot);
      } else if (selectedSlots.length < 2) {
        selectedSlots.add(slot);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Only 2 Slot Allowed")));
      }
    });
  }

  Future<void> _selectDate() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20)));

    if (picker != null) {
      setState(() {
        date.text = DateFormat('dd-MM-yyyy').format(picker).toString();
        selectedSlots.clear();
      });
      dev.log(getWeekNumber(date.text), name: "Date");
      await fetchTimeSlots(picker.toString().split(" ")[0], ruang);
    }
  }

  Future<void> _displayDetails() async {
    String? userName = FetchName.extractUsername();
    String? token = FetchToken.getToken();
    String? id = pinjamId;
    String? kode = kodeRuang;
    if (userName != null && token != null) {
      setState(() {
        name.text = userName;
        tokenNumber.text = token;
        idPinjam.text = id;
        kodeRuangan.text = kode;
      });
    } else {
      dev.log('username & token null');
    }
  }

  Future<int> _getSlots(String uid) async {
    int slots = await FetchSlots.getAllottedSlots(uid);
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Pinjam Ruangan',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    TextForm(
                        controller: idPinjam,
                        label: "ID Peminjaman",
                        readOnly: true,
                        prefixIcon: const Icon(Icons.token)),
                    const SizedBox(height: 10.0),
                    TextForm(
                        controller: name,
                        label: "Nama",
                        readOnly: true,
                        prefixIcon: const Icon(Icons.person)),
                    const SizedBox(height: 10.0),
                    TextForm(
                        controller: kodeRuangan,
                        label: "Kode Ruangan",
                        readOnly: true,
                        prefixIcon: const Icon(Icons.subject)),
                    const SizedBox(height: 10.0),
                    TextForm(
                      controller: date,
                      label: "Date",
                      readOnly: true,
                      prefixIcon: const Icon(Icons.date_range),
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Pilih Jadwal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF124076),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    BuildSlots(
                      timeSlots: timeSlots,
                      onSlotsSelected: _selectSlots,
                      selectedSlots: selectedSlots,
                    ),
                    const SizedBox(height: 20.0),
                    Button(
                      actionOnButton: () => _verifyDetails(),
                      buttonText: "Ajukan Pinjam",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
