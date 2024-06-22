import 'package:flutter/material.dart';
import 'package:semangat/models/notification_model.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Laporan Diterima',
      message: 'Laporan Anda tentang jalan berlubang telah diterima.',
      date: DateTime.now().subtract(Duration(hours: 1)),
    ),
    NotificationModel(
      title: 'Laporan Diproses',
      message: 'Laporan Anda sedang dalam proses perbaikan.',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    NotificationModel(
      title: 'Laporan Selesai',
      message: 'Perbaikan jalan berlubang telah selesai.',
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.message),
                  SizedBox(height: 5),
                  Text(
                    'Tanggal: ${notification.date.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: Icon(Icons.notifications),
              onTap: () {
                // Tindakan saat item diklik, misalnya tampilkan detail notifikasi
              },
            ),
          );
        },
      ),
    );
  }
}
