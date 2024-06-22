import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:semangat/history.dart';

class LaporanEdit extends StatefulWidget {
  const LaporanEdit({super.key, required this.id});

  final String id;

  @override
  State<LaporanEdit> createState() => _LaporanEditState();
}

class _LaporanEditState extends State<LaporanEdit> {
  late String id;
  final apiUrl = 'http://192.168.253.206:8080/laporan/edit/';
  TextEditingController namaController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController isiLaporanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.id;
    fetchProducts(id);
  }

  Future<void> fetchProducts(String data) async {
    final response =
        await http.get(Uri.parse('http://192.168.253.206:8080/laporan/$data'));
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      setState(() {
        namaController.text = getPostsData['nama_pelapor'];
        lokasiController.text = getPostsData['lokasi'];
        tanggalController.text = getPostsData['tanggal'];
        kategoriController.text = getPostsData['kategori_kerusakan'];
        isiLaporanController.text = getPostsData['isi_laporan'];
      });
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  Future<void> updatePostRequest() async {
    var map = <String, dynamic>{};
    map['nama_pelapor'] = namaController.text;
    map['lokasi'] = lokasiController.text;
    map['tanggal'] = tanggalController.text;
    map['kategori_kerusakan'] = kategoriController.text;
    map['isi_laporan'] = isiLaporanController.text;
    var response = await http.post(Uri.parse(apiUrl + id), body: map);
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
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
          content: const Text("Failed to change report!"),
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
          'Ubah Laporan',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: "Nama Pelapor"),
            ),
            TextField(
              controller: lokasiController,
              decoration: const InputDecoration(hintText: "Lokasi"),
            ),
            TextField(
              controller: tanggalController,
              decoration: const InputDecoration(hintText: "Tanggal"),
            ),
            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(hintText: "Kategori"),
            ),
            TextField(
              controller: isiLaporanController,
              decoration: const InputDecoration(hintText: "Catatan"),
            ),
            ElevatedButton(
              onPressed: updatePostRequest,
              child: const Text("Update Laporan"),
            ),
          ],
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
