import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_seminar/entryseminar.dart';
import 'dart:async';
import 'dbhelperseminar.dart';
import 'seminar.dart';

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  void initState() {
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
        title: Text('Aplikasi Tiket Seminar'),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.topCenter,
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.deepOrangeAccent,
                    child: Text("Seminar")),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/pesanan');
                  },
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.orangeAccent,
                      child: Text("Pembelian")),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
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
      ]),
    );
  }

  Future<Seminar> navigateToEntryForm(
      BuildContext context, Seminar seminar) async {
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
              child: Icon(Icons.date_range),
            ),
            title: Text(
              this.seminarList[index].judul,
              style: textStyle,
            ),
            subtitle:
                Text("Pembicara : " + this.seminarList[index].getPembicara +
                      "\nWaktu : " + this.seminarList[index].waktu+
                      "\nLokasi : " + this.seminarList[index].lokasi+
                      "\nKuota  : " + this.seminarList[index].kuota.toString()+
                      "\nHarga  : " + this.seminarList[index].harga.toString()
                ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //Memanggil Fungsi untuk Delete dari DB berdasarkan Seminar
                await dbHelperSeminar.delete(seminarList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var seminar = await navigateToEntryForm(context, this.seminarList[index]);
              // Memanggil Fungsi untuk Edit data
              await dbHelperSeminar.update(seminar);
              updateListView();
            },
          ),
        );
      },
    );
  }

//update List seminar
  void updateListView() {
    final Future<Database> dbFuture = dbHelperSeminar.initDb();
    dbFuture.then((database) {
// select data Seminar
      Future<List<Seminar>> seminarListFuture =
          dbHelperSeminar.getSeminarList();
      seminarListFuture.then((seminarList) {
        setState(() {
          this.seminarList = seminarList;
          this.count = seminarList.length;
        });
      });
    });
  }
}
