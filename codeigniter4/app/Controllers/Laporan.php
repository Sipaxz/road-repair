<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
use App\Models\LaporanModel;

class Laporan extends ResourceController
{
    use ResponseTrait;
// all users
    public function index()
    {
        $model = new LaporanModel();
        $data = $model->orderBy('id', 'DESC')->findAll();
        return $this->respond($data);
    }

// single user
public function show($id = null)
{
    $model = new LaporanModel();
    $data = $model->where('id', $id)->first();
    if ($data) {
        return $this->respond($data);
    } else { 
        return $this->failNotFound('Data tidak ditemukan.');
    }
} 

// create
public function create()
{
    $model = new LaporanModel();
    $data = [
        'nama_pelapor' => $this->request->getPost('nama_pelapor'),
        'lokasi' => $this->request->getPost('lokasi'),
        'tanggal' => $this->request->getPost('tanggal'),
        'kategori_kerusakan' => $this->request->getPost('kategori_kerusakan'),
        'isi_laporan' => $this->request->getPost('isi_laporan'),
    ];
    $model->insert($data);
    $response = [
        'status'    => 208,
        'error'     => null,
        'messages'  => [
            'success' => 'Data laporan berhasil ditambahkan.'
        ]
    ];
    return $this->respondCreated($response);
}

// update
public function update($id = null)
{
    $model = new LaporanModel();
    $data = [
        'nama_pelapor' => $this->request->getVar('nama_pelapor'),
        'lokasi' => $this->request->getVar('lokasi'),
        'tanggal' => $this->request->getVar('tanggal'),
        'kategori_kerusakan' => $this->request->getVar('kategori_kerusakan'),
        'isi_laporan' => $this->request->getVar('isi_laporan'),
    ];    
    $model->update($id, $data);
    $response = [
        'status'    => 200,
        'error'     => null,
        'messages'  => [
            'success' => 'Data laporan berhasil diubah.'
        ]   
    ];
    return $this->respond($response);
}

// delete
public function delete($id = null)
{
    $model = new LaporanModel();
    $data = $model->where('id', $id)->delete($id);
    if ($data) {
        $model->delete($id);
        $response = [
            'status'    => 200,
            'error'     => null,
            'messages'  => [
                'success' => 'Data laporan berhasil dihapus.'
            ]
        ];
        return $this->respondDeleted($response);
    } else {
        return $this->failNotFound('Data tidak ditemukan.');
    }
}
}
