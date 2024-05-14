import 'package:flutter/material.dart';

class EditPeminjaman extends StatefulWidget {
  final String bookingNumber;
  final String borrowerName;
  final String roomName;
  final String dateTime;

  const EditPeminjaman({super.key, 
    required this.bookingNumber,
    required this.borrowerName,
    required this.roomName,
    required this.dateTime,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditPeminjamanState createState() => _EditPeminjamanState();
}

class _EditPeminjamanState extends State<EditPeminjaman> {
  late TextEditingController _borrowerNameController;
  late TextEditingController _roomNameController;
  late TextEditingController _dateTimeController;

  @override
  void initState() {
    super.initState();
    _borrowerNameController = TextEditingController(text: widget.borrowerName);
    _roomNameController = TextEditingController(text: widget.roomName);
    _dateTimeController = TextEditingController(text: widget.dateTime);
  }

  @override
  void dispose() {
    _borrowerNameController.dispose();
    _roomNameController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Peminjaman'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _borrowerNameController,
              decoration: const InputDecoration(labelText: 'Nama Peminjam'),
            ),
            TextFormField(
              controller: _roomNameController,
              decoration: const InputDecoration(labelText: 'Ruangan yang Dipinjam'),
            ),
            TextFormField(
              controller: _dateTimeController,
              decoration: const InputDecoration(labelText: 'Tanggal/Waktu Peminjaman'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform update logic here
            String updatedBorrowerName = _borrowerNameController.text;
            String updatedRoomName = _roomNameController.text;
            String updatedDateTime = _dateTimeController.text;

            // You can pass the updated values back or perform any other action
            Navigator.of(context).pop({
              'borrowerName': updatedBorrowerName,
              'roomName': updatedRoomName,
              'dateTime': updatedDateTime,
            });
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
