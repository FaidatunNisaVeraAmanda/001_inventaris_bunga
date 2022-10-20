import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inventaris_bunga/database/db.dart';
import 'package:inventaris_bunga/modul/inventaris.dart';
import 'package:inventaris_bunga/tampilan/form.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Db database = Db();

  Future<List<Bunga>> getDataBungaaFromSQL() async {
    List<Bunga> bungaList;
    final Future<Database> dbFuture = database.initDb();

    // check database berhasil dibuka
    await dbFuture.then((databaseOPEN) async {
      Future<List<Bunga>> bungaListFuture = database.getBungaList();
      bungaList = await bungaListFuture.then((value) => value);
    });
    print(bungaList);
    return bungaList;
  }

  //navigasikan ke entry from 
  Future<Bunga> navigateToEntryForm(BuildContext context, Bunga bunga) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(bunga);
    }));
    // result disini sebagai nilai dari pop up data bunga
    return result;
  }

  Future<Bunga> navigateToEntryFormUpdate(
      BuildContext context, Bunga bunga) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(bunga);
    }));
    // result disini sebagai nilai dari pop up data bunga
    return result;
  }

  // tambah data bunga
  void addBunga(Bunga bunga) async {
    await database.insert(bunga);
  }

  // update data terbaru dari database
  void editBunga(Bunga bunga) async {
    await database.update(bunga);
  }

// menghapus data bunga
  void deleteBunga(Bunga bunga) async {
    await database.delete(bunga.kodeInventaris);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventaris Bunga Hias',),
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          iconSize: 40,
          onPressed: () async {
            var bunga = await navigateToEntryForm(context, null);

            if (bunga != null) {
            addBunga(bunga);}
          },
        ),
      ],),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.15,
              width: MediaQuery.of(context).size.width / 1.0,
              child: FutureBuilder(
                future: this.getDataBungaaFromSQL(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Bunga>> snapshot) {
                  if (snapshot.hasData) {
                    List<Bunga> bungaa = snapshot.data;
                    return ListView(
                      children: bungaa
                          .map(
                            (Bunga bunga) => Container(
                              color: Colors.deepPurple,
                              margin: EdgeInsets.all(9),
                              padding: EdgeInsets.all(5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.deepPurple[100],
                                  child: Icon(
                                    Icons.ac_unit_rounded,
                                    color: Colors.deepPurple[400],
                                    size: 40,
                                  ),
                                ),
                                title: Text(
                                  bunga.nama,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white,),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '( ' + bunga.latin + ' )',
                                    style: TextStyle(color: Colors.white),),
                                    Text('Kelas : ' + bunga.kelas, 
                                    style: TextStyle(color: Colors.deepPurple[100]),),
                                    Text('Keluarga : ' + bunga.keluarga,
                                    style: TextStyle(color: Colors.deepPurple[100]),),
                                    Text('Spesies : ' + bunga.spesies,
                                    style: TextStyle(color: Colors.deepPurple[100]),),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.all(7),
                                      child: Icon(
                                        Icons.delete,
                                        size: 40,
                                      )),
                                  onTap: () {
                                    deleteBunga(bunga);
                                    setState(() {
                                      getDataBungaaFromSQL();
                                    });
                                  },
                                ),
                                onTap: () async {
                                  var bungaUpdate =
                                      await navigateToEntryFormUpdate(
                                          context, bunga);
                                  if (bungaUpdate != null) {
                                    editBunga(bungaUpdate);
                                  }
                                },
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } 
                    return Center(child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple[100],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}