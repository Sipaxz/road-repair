// ignore: unused_import
import 'package:semangat/history.dart';
import 'package:semangat/home.dart';
import 'package:flutter/material.dart';
import 'package:semangat/laporan_add.dart';
import 'package:semangat/notification.dart';
import 'package:semangat/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var tabIndex = 0;
  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tabIndex, children: const [
        Home(),
        // const Text('History'),
        // const Text('History'),
        History(),
        History(),
        Notif(),
        Profile()
      ]),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            currentIndex: tabIndex,
            onTap: changeTabIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey.shade300,
            items: [
              itemBar(Icons.home, "Beranda"),
              itemBar(Icons.history, "Riwayat"),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.transparent,
                  ),
                  label: ""),
              itemBar(Icons.notifications, "Notifikasi"),
              itemBar(Icons.person, "Profil")
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LaporanAdd())),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

itemBar(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
