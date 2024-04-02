import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 131, 22, 22);

void main() {
  runApp(DetailRuangan());
}

class DetailRuangan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Ruangan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailRuanganPage(),
    );
  }
}

class DetailRuanganPage extends StatefulWidget {
  @override
  _DetailRuanganPageState createState() => _DetailRuanganPageState();
}

class _DetailRuanganPageState extends State<DetailRuanganPage> {
  String namaKelas = "KU3.01.01";
  String mataKuliah = "Mata Kuliah: MobPro";
  String lantai = "Lantai 3";
  String ongoingJam = "06.30-07.00 AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Ruangan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nama Kelas: $namaKelas',
              style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 20),
            Text(
              'Lantai: $lantai',
              style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 20),
            Text(
              'Ongoing: $ongoingJam',
              style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 20),
            Text(
              mataKuliah,
              style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
