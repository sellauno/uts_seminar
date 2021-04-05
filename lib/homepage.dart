import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_seminar/entryseminar.dart';
import 'dart:async';
import 'dbhelperseminar.dart';
import 'dbhelperpesanan.dart';
import 'seminar.dart';
import 'pesanan.dart';

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  void initState(){
      updateListView();
  }

  DbHelperSeminar dbHelperSeminar = DbHelperSeminar();
  int count = 0;
  List<Seminar> seminarList;
  @override
  Widget build(BuildContext context) {
    if (seminarList == null) {
      seminarList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Seminar'),
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
              child: Text("Tambah Seminar"),
              onPressed: () async {
                var seminar = await navigateToEntryForm(context, null);
                if (seminar != null) {
//TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelperSeminar.insert(seminar);
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

  Future<Seminar> navigateToEntryForm(BuildContext context, Seminar seminar) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
    return EntryFormSeminar(seminar);
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
              this.seminarList[index].judul,
              style: textStyle,
            ),
            subtitle: Text("Harga : " + this.seminarList[index].harga.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Seminar
                await dbHelperSeminar.delete(seminarList[index].id);
                updateListView();
              },
            ), 
            onTap: () async {
            //  var seminar = await navigateToEntryForm(context, this.seminarList[index]);
                //TODO 4 Panggil Fungsi untuk Edit data
            //    await dbHelperSeminar.update(seminar);
                updateListView();
            },
          ),
        );
      },
    );
  }
  void addData() async{
      var add1 = Seminar("Seminar1", "DateTime.now()", 50000, 50, "Zoom Meeting", "PemateriA");
      await dbHelperSeminar.insert(add1);
      updateListView();
  }

//update List seminar
  void updateListView() {
    final Future<Database> dbFuture = dbHelperSeminar.initDb();
    dbFuture.then((database) {
// select data Seminar
      Future<List<Seminar>> seminarListFuture = dbHelperSeminar.getSeminarList();
      seminarListFuture.then((seminarList) {
        setState(() {
          this.seminarList = seminarList;
          this.count = seminarList.length;
        });
      });
    });
  }
}
