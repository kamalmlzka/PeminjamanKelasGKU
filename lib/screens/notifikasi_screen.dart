import 'package:flutter/material.dart';
import 'package:peminjaman_kelas_gku/screens/edit_peminjaman.dart';
import '/widgets/ddm.dart';
import 'penerimaan_peminjaman.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Pengajuan Peminjaman Kelas',
      'date': 'Senin, 20 Maret 2024',
      'room': 'KU3-04-18',
      'time': '08:00 - 10:00',
      'status': 'pending',
    },
    {
      'title': 'Peminjaman Kelas Disetujui',
      'date': 'Selasa, 21 Maret 2024',
      'room': 'KU3-04-18',
      'time': '10:00 - 12:00',
      'status': 'accepted',
    },
    {
      'title': 'Peminjaman Kelas Berlangsung',
      'date': 'Rabu, 22 Maret 2024',
      'room': 'KU3-04-18',
      'time': '13:00 - 15:00',
      'status': 'berlangsung',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Notification',
      child: ListView(
        children: [
          buildSection('Pending', 'pending'),
          buildSection('Accepted', 'accepted'),
          buildSection('Berlangsung', 'berlangsung'),
        ],
      ),
    );
  }

  Widget buildSection(String title, String status) {
    List<Map<String, String>> filteredNotifications = notifications
        .where((notification) => notification['status'] == status)
        .toList();

    if (filteredNotifications.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if there are no notifications for this section
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              const Expanded(
                child: Divider(
                  indent: 5,
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: filteredNotifications
              .map((notification) => buildNotificationCard(notification))
              .toList(),
        ),
        const SizedBox(height: 10), // Add some spacing between sections
      ],
    );
  }

  Widget buildNotificationCard(Map<String, String> notification) {
// Default color for pending status
    Color cancelButtonColor = Colors.red; // Default color for cancel button
    Color actionButtonColor = Colors.grey; // Default color for action button
    String actionButtonText = 'Edit'; // Default text for action button
    bool showEditButton = true; // Default value to show edit button

    // Set colors and button text based on status
    switch (notification['status']) {
      case 'pending':
        break;
      case 'accepted':
        actionButtonColor = Colors.green;
        actionButtonText = 'Start';
        break;
      case 'berlangsung':
        showEditButton = false; // Hide edit button for 'berlangsung' status
        break;
      default:
    }

    return Card(
      child: InkWell(
        onTap: () {
          if (notification['status'] == 'accepted') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PeminjamanDetailPage()));
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(notification['title']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hari/Tanggal: ${notification['date']}'),
                  Text('Ruang: ${notification['room']}'),
                  Text('Waktu: ${notification['time']}'),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(cancelButtonColor),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Perform cancel action here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Batal Pinjam'),
                          content: const Text(
                              'Anda akan membatalkan status peminjaman. Apakah Anda ingin melanjutkan?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              child: const Text(
                                'Tidak',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // Remove notification from the list
                                  notifications.remove(notification);
                                });
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green, // Background color
                              ),
                              child: const Text(
                                'Ya',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                if (showEditButton) // Render the edit button conditionally
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(actionButtonColor),
                    ),
                    child: Text(
                      actionButtonText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (notification['status'] == 'accepted') {
                        // Perform start action here
                        setState(() {
                          // Move the notification from 'accepted' to 'berlangsung'
                          notification['title'] =
                              'Peminjaman Kelas Berlangsung';
                          notification['status'] = 'berlangsung';
                        });
                      } else if (notification['status'] == 'pending') {
                        // Perform edit action here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const EditPeminjaman(
                              bookingNumber:
                                  '0018', // Provide the booking details
                              borrowerName: 'Alek',
                              roomName: 'KU3.01.01',
                              dateTime: '2024-04-24 14:00',
                            );
                          },
                        );
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
