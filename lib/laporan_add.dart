import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:semangat/history.dart';

class LaporanAdd extends StatefulWidget {
  const LaporanAdd({super.key});

  @override
  State<LaporanAdd> createState() => _LaporanAddState();
}

class _LaporanAddState extends State<LaporanAdd> {
  final apiUrl = 'http://192.168.253.206:8080/laporan/create';
  final namaController = TextEditingController();
  final lokasiController = TextEditingController();
  final tanggalController = TextEditingController();
  final kategoriController = TextEditingController();
  final isiLaporanController = TextEditingController();

  Future<void> sendPostRequest() async {
    var map = <String, dynamic>{};
    map['nama_pelapor'] = namaController.text;
    map['lokasi'] = lokasiController.text;
    map['tanggal'] = tanggalController.text;
    map['kategori_kerusakan'] = kategoriController.text;
    map['isi_laporan'] = isiLaporanController.text;
    var response = await http.post(Uri.parse(apiUrl), body: map);
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 201) {
      var getPostsData = json.decode(response.body);
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getPostsData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                navHistory();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to create report!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navHistory() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const History();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Laporan',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                    hintText: "Nama Pelapor", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: lokasiController,
                decoration: const InputDecoration(
                    hintText: "Lokasi", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: tanggalController,
                decoration: const InputDecoration(
                    hintText: "Tanggal", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(
                    hintText: "Kategori", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: isiLaporanController,
                decoration: const InputDecoration(
                    hintText: "Catatan", border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: sendPostRequest,
                child: const Text("Kirim Laporan",
                    style: TextStyle(color: Colors.black)
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navHistory,
        tooltip: 'Increment',
        child: const Icon(Icons.home),
      ),
    );
  }
}
