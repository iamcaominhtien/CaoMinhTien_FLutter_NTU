import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SinhVien {
  String? id, ten, lop, nam, que_quan, anh;

  SinhVien({
    required this.id,
    required this.ten,
    this.lop,
    this.nam,
    this.que_quan,
    this.anh,
  });

  factory SinhVien.fromJon(Map<String, dynamic> json) {
    return SinhVien(
        id: json['id'],
        ten: json['ten'],
        lop: json['lop'],
        nam: json['nam'],
        que_quan: json['que_quan'],
        anh: json['anh']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lop': lop,
      'nam': nam,
      'que_quan': que_quan,
      'ten': ten,
      'anh': anh,
    };
  }
}

class SinhVienSnapShot {
  SinhVien? sv;
  DocumentReference? docf;

  SinhVienSnapShot({this.sv, this.docf});

  factory SinhVienSnapShot.fromSnapShot(DocumentSnapshot s) {
    return SinhVienSnapShot(
        sv: SinhVien.fromJon(s.data() as Map<String, dynamic>),
        docf: s.reference);
  }

  Future<void> update(SinhVien sv) async {
    await docf!.update(sv.toJson());
  }

  Future<void> del() async {
    await docf!.delete();
  }

  static Future<DocumentReference<Map<String, dynamic>>> add(
      SinhVien sv) async {
    return await FirebaseFirestore.instance
        .collection('Sinhvien')
        .add(sv.toJson());
  }

  static Stream<List<SinhVienSnapShot>> listAllSinhVien() {
    Stream<QuerySnapshot<Map<String, dynamic>>> qs =
        FirebaseFirestore.instance.collection('Sinhvien').snapshots();
    Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> listDocSnap =
        qs.map((event) => event.docs);
    debugPrint('listDocSnap: ' + listDocSnap.length.toString());
    return listDocSnap.map(
        (lds) => lds.map((e) => SinhVienSnapShot.fromSnapShot(e)).toList());
  }
}
