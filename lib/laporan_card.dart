import 'package:flutter/material.dart';
import 'package:semangat/detail_page.dart';
import 'package:semangat/laporan.dart';

class LaporanCard extends StatelessWidget {
  const LaporanCard({super.key, required this.laporan, required double width});
  final Laporan laporan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return DetailPage(laporan: laporan);
            }),
          ),
        );
      },
      child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pelapor : ${laporan.namaPelapor}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text('Lokasi : ${laporan.lokasi}'),
              Text('Tanggal : ${laporan.tanggal}'),
              Text('Kategori : ${laporan.kategori}'),
              Text('Catatan : ${laporan.isiLaporan}'),
            ],
          )),
    );
  }
}
