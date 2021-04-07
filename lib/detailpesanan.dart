import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pesanan.dart';

class DetailPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pesanan pesanan = ModalRoute.of(context).settings.arguments;
    final String nama = pesanan.nama;
    final String idSeminar = pesanan.getIdSeminar.toString();
    final String email = pesanan.email;
    final String notelp = pesanan.noTelp;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesanan"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, top: 10),
            padding: EdgeInsets.all(8),
            child: Text(
              "Nama             : $nama",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.all(8),
            child: Text(
              "Email             : $email",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.all(8),
            child: Text(
              "No Telepon   : $notelp",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.all(8),
            child: Text(
              "Id Seminar    : $idSeminar",
            ),
          ),
        ],
      ),
    );
  }
}
