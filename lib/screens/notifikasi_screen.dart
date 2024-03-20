import 'package:flutter/material.dart';
import 'package:peminjaman_kelas_gku/widgets/ddm.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _NotificationScreenState('test');
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  final String notificationMessage;

  _NotificationScreenState(this.notificationMessage);

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Notification',
      child: ListView(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('Pengajuan Peminjaman Kelas'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hari/Tanggal: Senin, 20 Maret 2024'),
                      Text('Ruang: KU3-04-18'),
                      Text('Waktu: 08:00 - 10:00')
                    ],
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
