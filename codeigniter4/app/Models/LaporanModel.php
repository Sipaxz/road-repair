<?php namespace app\Models;

use CodeIgniter\Model;

class LaporanModel extends Model
{
    protected $table = 'laporan';
    protected $primarykey = 'id';
    protected $allowedFields = ['nama_pelapor', 'lokasi', 'tanggal', 'kategori_kerusakan', 'isi_laporan'];
}