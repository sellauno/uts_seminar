import 'package:flutter/material.dart';
import 'seminar.dart';
import 'pesanan.dart';

class EntryForm extends StatefulWidget {
  final Pesanan pesanan;
  EntryForm(this.pesanan);
  @override
  EntryFormState createState() => EntryFormState(this.pesanan);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Pesanan pesanan;
  EntryFormState(this.pesanan);
  TextEditingController namaController = TextEditingController();
  TextEditingController idSeminarController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//kondisi
    if (pesanan != null) {
      namaController.text = pesanan.nama;
      idSeminarController.text = pesanan.getIdSeminar.toString();
      emailController.text = pesanan.email;
      notelpController.text = pesanan.noTelp();
    }
//ubah
    return Scaffold(
        appBar: AppBar(
          title: pesanan == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// email
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// No Telepon
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: notelpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'No Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// idSeminar
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: idSeminarController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Id Seminar',
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
                          if (pesanan == null) {
// tambah data
                            pesanan = Pesanan(namaController.text,
                                emailController.text,
                                notelpController.text,
                                int.parse(idSeminarController.text));
                          } else {
// ubah data
                            pesanan.nama = namaController.text;
                            pesanan.email = emailController.text;
                            pesanan.noTelp = notelpController.text;
                            pesanan.idSeminar = int.parse(idSeminarController.text);
                          }
// kembali ke layar sebelumnya dengan membawa objek pesanan
                          Navigator.pop(context, pesanan);
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