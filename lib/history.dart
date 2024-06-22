import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:semangat/laporan.dart';
import 'package:semangat/laporan_card.dart';
import 'package:semangat/laporan_add.dart';
import 'package:semangat/laporan_edit.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<List<Laporan>> fetchLaporan() async {
    final response =
        await http.get(Uri.parse('http://192.168.253.206:8080/laporan'));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listPosts = getPostsData.map((i) => Laporan.fromJson(i)).toList();
      return listPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Laporan>> futurePosts;
  void navLaporanAdd() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LaporanAdd();
    }));
  }

  void navLaporanEdit(String data) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LaporanEdit(id: data);
    }));
  }

  Future<void> delLaporan(String data) async {
    final response =
        await http.delete(Uri.parse('http://192.168.253.206:8080/laporan/$data'));

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      // print(getPostsData)['messages']);
      // print(getPostsData)['messages']['success']);
      showDialog<String>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Message'),
                content: Text(getPostsData['messages']['success']),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          futurePosts = fetchLaporan();
                        });
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'))
                ],
              ));
    } else {
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to delete report!"),
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

  @override
  void initState() {
    super.initState();
    futurePosts = fetchLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: FutureBuilder<List<Laporan>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        var get = (snapshot.data as List<Laporan>)[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LaporanCard(
                              laporan: Laporan(
                                id: get.id,
                                namaPelapor: get.namaPelapor,
                                lokasi: get.lokasi,
                                tanggal: get.tanggal,
                                kategori: get.kategori,
                                isiLaporan: get.isiLaporan,
                              ),
                              width: 20,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      navLaporanEdit(get.id);
                                    },
                                    child: const Icon(Icons.edit)),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('Message'),
                                              content: const Text(
                                                  "Apakah data akan dihapus?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    delLaporan(get.id);
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5)
                          ],
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: (snapshot.data as List<Laporan>).length);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: navLaporanAdd,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      //   ),
    );
  }
}
