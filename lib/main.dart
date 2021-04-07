import 'package:flutter/material.dart';
import 'package:uts_seminar/homepage.dart';
import 'package:uts_seminar/pesananpage.dart';

import 'detailpesanan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambahkan Item',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/pesanan': (context) => PesananPage(),
        '/detailPesanan': (context) => DetailPesanan(),
      },
    );
  }
}
