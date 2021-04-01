class Pesanan {
  int _idPesanan;
  String _nama;
  String _email;
  String _noTelp;
  int idSeminar;

//setter dan getter id
  int get idPesanan => this._idPesanan;
  set idPesanan(int value) => this._idPesanan = value;
//setter dan getter nama
  get nama => this._nama;
  set nama(value) => this._nama = value;
//setter dan getter email
  get email => this._email;
  set email(value) => this._email = value;
//setter dan getter noTelp
  get noTelp => this._noTelp;
  set noTelp(value) => this._noTelp = value;
//setter dan getter idSeminar
  get getIdSeminar => this.idSeminar;
  set setIdSeminar(idSeminar) => this.idSeminar = idSeminar;

// konstruktor versi 1
  Pesanan(this._nama, this._email, this._noTelp, this.idSeminar);

// konstruktor versi 2: konversi dari Map ke Pesanan
  Pesanan.fromMap(Map<String, dynamic> map) {
    this._idPesanan = map['idPesanan'];
    this._nama = map['nama'];
    this._email = map['email'];
    this._noTelp = map['noTelp'];
    this.idSeminar = map['idSeminar'];
  }

// konversi dari Pesanan ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['idPesanan'] = this._idPesanan;
    map['nama'] = this._nama;
    map['email'] = this._email;
    map['noTelp'] = this._noTelp;
    map['idSeminar'] = this.idSeminar;
    return map;
  }
}
