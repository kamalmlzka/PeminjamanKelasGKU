import 'package:flutter/material.dart';
import 'package:peminjaman_kelas_gku/screens/home_screen.dart';
// import '../gku/gku_home_screen.dart';
// import '../screens/dashboard.dart';
// import '../screens/notification.dart';
// import '../screens/profile.dart';

class DDM extends StatelessWidget {
  final Widget child;
  final String title;

  const DDM({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 131, 22, 22),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 131, 22, 22),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            // Inside your drawer
            ListTile(
              title: const Text('Beranda'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              title: const Text('Daftar Ruangan'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const GkuHomeScreen()),
                // );
              },
            ),
            ListTile(
              title: const Text('Notifikasi'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Notifications()),
                // );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Profile()),
                // );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LogoutPage()),
                // );
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}