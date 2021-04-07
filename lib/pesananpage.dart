import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_seminar/entryform.dart';
import 'dart:async';
import 'dbhelperpesanan.dart';
import 'pesanan.dart';

//pendukung program asinkron
class PesananPage extends StatefulWidget {
  @override
  PesananPageState createState() => PesananPageState();
}

class PesananPageState extends State<PesananPage> {

  void initState(){
    updateListView();
  }

  DbHelperPesanan dbHelper = DbHelperPesanan();
  int count = 0;
  List<Pesanan> itemList;
  @override
  Widget build(BuildContext context) {
    //kondisi apabila list masih kosong
    if (itemList == null) {
      itemList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.topCenter,
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Container(
                    alignment: Alignment.center, 
                    color: Colors.orangeAccent, 
                    child: Text("Seminar")
                    )
                    ),
              ),
              Expanded(
                child: Container(alignment: Alignment.center, color: Colors.deepOrangeAccent, child: Text("Pembelian")),
              ),
            ],
          ),
        ),
        Expanded(
          //menampilkan list pesanan
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(20),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                var pesanan = await navigateToEntryForm(context, null);
                if (pesanan != null) {
                  //Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(pesanan);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
        ),
      ]),
    );
  }
//Berpindah ke Halaman Form
  Future<Pesanan> navigateToEntryForm(BuildContext context, Pesanan item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
        return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList[index].nama,
              style: textStyle,
            ),
            subtitle: Text("Id Seminar : " + this.itemList[index].idSeminar.toString()),
            onTap: () {
                  Navigator.pushNamed(context, '/detailPesanan', arguments: this.itemList[index]);
                },
          ),
        );
      },
    );
  }

//update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
//Select data dari DB
      Future<List<Pesanan>> itemListFuture = dbHelper.getPesananList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
