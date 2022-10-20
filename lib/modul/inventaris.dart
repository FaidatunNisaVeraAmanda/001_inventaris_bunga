import 'dart:math';

import 'package:flutter/cupertino.dart';

class Bunga {
  int _kodeInvetaris;
  String _nama, _latin, _kelas, _keluarga, _spesies;

  // konstruk
  Bunga(this._nama, this._latin, this._kelas, this._keluarga, this._spesies);
  Bunga.addKode(this._kodeInvetaris);

  // transfer atau simpan data
  Bunga.fromJson(Map<String, dynamic> json) {
    this._kodeInvetaris = json['kode_inventaris'];
    this._nama = json['nama'];
    this._latin = json['latin'];
    this._kelas = json['kelas'];
    this._keluarga = json['keluarga'];
    this._spesies = json['spesies'];
  }
  //memanggil nilai dari inisialisasi sebelumnya
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['kode_inventaris'] = kodeInventaris;
    map['nama'] = nama;
    map['latin'] = latin;
    map['kelas'] = kelas;
    map['keluarga'] = keluarga;
    map['spesies'] = spesies;
    return map;
  }

  // pemanggilan data
  int get kodeInventaris => _kodeInvetaris;
  String get nama => _nama;
  String get latin => _latin;
  String get kelas => _kelas;
  String get keluarga => _keluarga;
  String get spesies => _spesies;

  //penyetelan data
  set kodeInventaris(int value) => _kodeInvetaris = value;
  set nama(String value) => _nama = value;
  set latin(String value) => _latin = value;
  set kelas(String value) => _kelas = value;
  set keluarga(String value) => _keluarga = value;
  set spesies(String value) => _spesies = value;
}
