class Laporan {
  String id;
  String namaPelapor;
  String lokasi;
  String tanggal;
  String kategori;
  String isiLaporan;

  Laporan(
      {required this.id,
      required this.namaPelapor,
      required this.lokasi,
      required this.tanggal,
      required this.kategori,
      required this.isiLaporan,
      });
    

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'],
      namaPelapor: json['nama_pelapor'],
      lokasi: json['lokasi'],
      tanggal: json['tanggal'],
      kategori: json['kategori_kerusakan'],
      isiLaporan: json['isi_laporan'],);
  }
}