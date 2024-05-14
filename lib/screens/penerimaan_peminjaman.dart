import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Peminjaman Kelas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PeminjamanDetailPage(),
    );
  }
}

class PeminjamanDetailPage extends StatelessWidget {
  final String noPeminjaman = '12345';
  final String namaPeminjam = 'John Doe';
  final String kelasDipinjam = 'Kelas X IPA';
  final String tanggalWaktuPeminjaman = '22 April 2024, 10:00';
  final String statusPeminjaman = 'Diterima';

  const PeminjamanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Peminjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No. Peminjaman: $noPeminjaman'),
            Text('Nama Peminjam: $namaPeminjam'),
            Text('Kelas yang Dipinjam: $kelasDipinjam'),
            Text('Tanggal/Waktu Peminjaman: $tanggalWaktuPeminjaman'),
            const SizedBox(height: 16.0),
            const Text('Status Peminjaman:'),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
              ),
              child: const Text('Peminjaman Diterima'),
            ),
          ],
        ),
      ),
    );
  }
}