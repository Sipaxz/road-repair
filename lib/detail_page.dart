import 'package:flutter/material.dart';
import 'package:semangat/laporan.dart';

class DetailPage extends StatelessWidget {
  final Laporan laporan;
  const DetailPage({super.key, required this.laporan});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Page',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'id: ${laporan.id}',
        ),
        Text('Nama Pelapor: ${laporan.namaPelapor}', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(
          height: 5,
        ),
        Text('Lokasi: ${laporan.lokasi}'),
        Text('Tanggal: ${laporan.tanggal}'),
        Text('Kategori: ${laporan.kategori}'),
        Text('Catatan: ${laporan.isiLaporan}'),
      ])),
    );
  }
}
