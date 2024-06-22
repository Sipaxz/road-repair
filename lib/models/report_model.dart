class Laporan {
  final int id;
  final String nama;
  final String lokasi;
  final String tanggal;
  final String kategori;
  final String isiLaporan;

  Laporan({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.tanggal,
    required this.kategori,
    required this.isiLaporan,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'],
      nama: json['nama'],
      lokasi: json['lokasi'],
      tanggal: json['tanggal'],
      kategori: json['kategori'],
      isiLaporan: json['isi_laporan'],
    );
  }
}
