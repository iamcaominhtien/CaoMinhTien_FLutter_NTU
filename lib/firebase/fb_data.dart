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

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      ten: json['ten'],
      lop: json['lop'],
      nam: json['nam'],
      que_quan: json['que_quan'],
      anh: json['anh'],
    );
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
  late DocumentReference? documentReference;

  SinhVienSnapShot({this.sv, this.documentReference});

  factory SinhVienSnapShot.fromSnapShot(DocumentSnapshot ds) {
    return SinhVienSnapShot(
      sv: SinhVien.fromJson(ds.data() as Map<String, dynamic>),
      documentReference: ds.reference,
    );
  }

  Future update(SinhVien sv) async {
    await documentReference!.update(sv.toJson());
  }

  Future del() async {
    await documentReference!.delete();
  }

  static Future<DocumentReference> add(SinhVien sv) async {
    return await FirebaseFirestore.instance
        .collection('Sinhvien')
        .add(sv.toJson());
  }

  static Stream<List<SinhVienSnapShot>> listAllSinhVien() {
    Stream<QuerySnapshot> qs =
        FirebaseFirestore.instance.collection('Sinhvien').snapshots();
    debugPrint(qs.length.toString());
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((event) => event.docs);
    return listDocSnap.map((lds) =>
        lds.map((docSnap) => SinhVienSnapShot.fromSnapShot(docSnap)).toList());
  }
}
