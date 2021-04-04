import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_seminar/entryform.dart';
import 'dart:async';
import 'dbhelperseminar.dart';
import 'dbhelperpesanan.dart';
import 'seminar.dart';
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
    if (itemList == null) {
      itemList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Item"),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
//TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

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
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                await dbHelper.delete(itemList[index].idPesanan);
                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList[index]);
                //TODO 4 Panggil Fungsi untuk Edit data
                await dbHelper.update(item);
                updateListView();
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
//TODO 1 Select data dari DB
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
