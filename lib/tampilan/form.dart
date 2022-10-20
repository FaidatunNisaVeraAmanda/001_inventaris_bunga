import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventaris_bunga/modul/inventaris.dart';

class EntryForm extends StatefulWidget {
  final Bunga bunga;
  EntryForm(this.bunga);
  @override
  EntryFormState createState() => EntryFormState(this.bunga);
}

class EntryFormState extends State<EntryForm> {
  Bunga bunga;
  EntryFormState(this.bunga);
  TextEditingController namaController = TextEditingController();
  TextEditingController latinController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController keluargaController = TextEditingController();
  TextEditingController spesiesontroller = TextEditingController();
  // TextEditingController kodeInventarisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (bunga != null) {
      namaController.text = bunga.nama;
      latinController.text = bunga.latin;
      kelasController.text = bunga.kelas;
      keluargaController.text = bunga.keluarga;
      spesiesontroller.text = bunga.spesies;
      // kodeInventarisController.text = bunga.kodeInventaris.toInt();
    }
    return Scaffold(
        appBar: AppBar(
          title: bunga == null ? Text('Tambah') : Text('Edit'),
          backgroundColor: Colors.deepPurple[600],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama bunga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Bunga',
                    labelStyle: TextStyle(color: Colors.deepPurple[700]),
                    fillColor: Colors.deepPurple[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // latin
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: latinController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Latin',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // kelas
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kelasController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kelas',
                    labelStyle: TextStyle(color: Colors.deepPurple[700]),
                    fillColor: Colors.deepPurple[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              //keluarga
              Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                child: TextField(
                  controller: keluargaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Keluarga',
                    labelStyle: TextStyle(color: Colors.deepPurple[700]),
                    fillColor: Color.fromARGB(255, 209, 196, 233),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ), 
                  ),
                  onChanged: (value) {},
                ),
              ),
              //spesies
              Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                child: TextField(
                  controller: spesiesontroller,
                  keyboardType: TextInputType.text, 
                  decoration: InputDecoration(
                    labelText: 'Spesies',
                    labelStyle: TextStyle(color: Colors.deepPurple[700]),
                    fillColor: Colors.deepPurple[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),

              // button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // save
                    Expanded(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          // cetak();
                          if (bunga == null) {
                            bunga = Bunga(
                                namaController.text,
                                latinController.text,
                                kelasController.text,
                                keluargaController.text,
                                spesiesontroller.text);
                          } else {
                            bunga.nama = namaController.text;
                            bunga.latin = latinController.text;
                            bunga.kelas = kelasController.text;
                            bunga.keluarga = keluargaController.text;
                            bunga.spesies = spesiesontroller.text;
                          }
                          Navigator.pop(context, bunga);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // cancel
                    Expanded(
                      child: ElevatedButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
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
        ),);
  }
}