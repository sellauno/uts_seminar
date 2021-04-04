import 'package:flutter/material.dart';
import 'seminar.dart';
import 'pesanan.dart';

class EntryFormSeminar extends StatefulWidget {
  final Seminar seminar;
  EntryFormSeminar(this.seminar);
  @override
  EntryFormSeminarState createState() => EntryFormSeminarState(this.seminar);
}

class EntryFormSeminarState extends State<EntryFormSeminar> {
  Seminar seminar;
  EntryFormSeminarState(this.seminar);
  TextEditingController judulController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController kuotaController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController pembicaraController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//kondisi
    if (seminar != null) {
      judulController = seminar.judul;
 //     waktuController = seminar.waktu;
      hargaController = seminar.harga;
      kuotaController = seminar.kuota;
      lokasiController = seminar.lokasi;
      pembicaraController = seminar.getPembicara;
    }
//ubah
    return Scaffold(
        appBar: AppBar(
          title: seminar == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// judul
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: judulController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// waktu
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                 child: TextField(
//                   controller: waktuController,
//                   keyboardType: TextInputType.datetime,
//                   decoration: InputDecoration(
//                     labelText: 'Waktu',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (value) {
// //
//                   },
//                 ),
//               ),
// Harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// kuota
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kuotaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kuota',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// Lokasi
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: lokasiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Lokasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// Pembicara
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: pembicaraController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Pembicara',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
// tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (seminar == null) {
// tambah data Seminar(this._judul, this._waktu, this._harga, this._kuota, this._lokasi, this._pembicara);
                            seminar = Seminar(judulController.text,
                              //  DateTime.parse(waktuController.text),
                                int.parse(hargaController.text),
                                int.parse(kuotaController.text),
                                lokasiController.text,
                                pembicaraController.text);
                          } else {
// ubah data
                            seminar.judul = judulController.text;
                      //      seminar.waktu = DateTime.parse(waktuController.text);
                            seminar.harga = int.parse(hargaController.text);
                            seminar.kuota = int.parse(kuotaController.text);
                            seminar.lokasi = lokasiController.text;
                            seminar.setPembicara = pembicaraController.text;
                          }
// kembali ke layar sebelumnya dengan membawa objek seminar
                          Navigator.pop(context, seminar);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
// tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
