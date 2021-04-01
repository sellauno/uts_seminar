class Seminar {
  int _id;
  String _judul;
  DateTime _waktu;
  int _harga;
  int _kuota;
  String _lokasi;
  String _pembicara;

//setter dan getter id
  int get id => this._id;
  set id(int value) => this._id = value;
//setter dan getter judul
  get judul => this._judul;
  set judul(value) => this._judul = value;
//setter dan getter waktu
  get waktu => this._waktu;
  set waktu(value) => this._waktu = value;
//setter dan getter harga
  get harga => this._harga;
  set harga(value) => this._harga = value;
//setter dan getter kuota
  get kuota => this._kuota;
  set kuota(value) => this._kuota = value;
//setter dan getter lokasi
  get lokasi => this._lokasi;
  set lokasi(value) => this._lokasi = value;
//setter dan getter pembicara
  get getPembicara => this._pembicara;
  set setPembicara(value) => this._pembicara = value;

// konstruktor versi 1
  Seminar(this._judul, this._waktu, this._harga, this._kuota, this._lokasi,
      this._pembicara);

// konstruktor versi 2: konversi dari Map ke Seminar
  Seminar.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._judul = map['judul'];
    this._waktu = map['waktu'];
    this._harga = map['harga'];
    this._kuota = map['kuota'];
    this._lokasi = map['lokasi'];
    this._pembicara = map['pembicara'];
  }

// konversi dari Seminar ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['judul'] = this._judul;
    map['waktu'] = this._waktu;
    map['harga'] = this._harga;
    map['kuota'] = this._kuota;
    map['lokasi'] = this._lokasi;
    map['pembicara'] = this._pembicara;
    return map;
  }
}
