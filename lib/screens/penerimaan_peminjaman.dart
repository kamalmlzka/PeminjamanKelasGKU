import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Peminjaman Kelas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeminjamanDetailPage(),
    );
  }
}

class PeminjamanDetailPage extends StatelessWidget {
  final String noPeminjaman = '12345';
  final String namaPeminjam = 'John Doe';
  final String kelasDipinjam = 'Kelas X IPA';
  final String tanggalWaktuPeminjaman = '22 April 2024, 10:00';
  final String statusPeminjaman = 'Diterima';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Peminjaman'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No. Peminjaman: $noPeminjaman'),
            Text('Nama Peminjam: $namaPeminjam'),
            Text('Kelas yang Dipinjam: $kelasDipinjam'),
            Text('Tanggal/Waktu Peminjaman: $tanggalWaktuPeminjaman'),
            SizedBox(height: 16.0),
            Text('Status Peminjaman:'),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
              ),
              child: Text('Peminjaman Diterima'),
            ),
          ],
        ),
      ),
    );
  }
}