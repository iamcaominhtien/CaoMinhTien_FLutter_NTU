import 'package:caominhtien_61cntt2/firebase/dialog.dart';
import 'package:caominhtien_61cntt2/firebase/fb_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SVDetail extends StatefulWidget {
  const SVDetail({Key? key, this.svSnapShot, this.xem}) : super(key: key);

  final SinhVienSnapShot? svSnapShot;
  final bool? xem;

  @override
  State<SVDetail> createState() => _SVDetailState();
}

class _SVDetailState extends State<SVDetail> {
  SinhVienSnapShot? svSnapShot;
  bool? see;
  String btnLabel = 'Thêm';
  String title = 'Thêm sinh viên mới';
  bool imageChange = false; //Nếu chọn ảnh thì có giá trị true
  XFile? xImg; //Khi chọn 1 ảnh thì thông tin cấu hình lưu trong biến này
  BuildContext? dialogContext;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtLop = TextEditingController();
  TextEditingController txtNam = TextEditingController();
  TextEditingController txtQueQuan = TextEditingController();
  TextEditingController txtTen = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    svSnapShot = widget.svSnapShot;
    see = widget.xem;

    //Update or See
    if (svSnapShot != null) {
      txtId.text = svSnapShot!.sv!.id ?? "";
      txtLop.text = svSnapShot!.sv!.lop ?? "";
      txtTen.text = svSnapShot!.sv!.ten ?? "";
      txtQueQuan.text = svSnapShot!.sv!.que_quan ?? "";
      txtNam.text = svSnapShot!.sv!.nam ?? "";

      if (see == true) {
        title = 'Thông tin sinh viên';
        btnLabel = 'Đóng';
      } else {
        title = 'Cập nhật thông tin';
        btnLabel = 'Cập nhật';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: imageChange
                    ? Image.file(
                        File(xImg!.path),
                      )
                    : svSnapShot?.sv!.anh != null
                        ? Image.network(svSnapShot!.sv!.anh!)
                        : null,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      see == true ? null : _chonAnh(context);
                    },
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(
                  label: Text('Id'),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(
                  label: Text('Tên'),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtLop,
                decoration: const InputDecoration(
                  label: Text('Lớp'),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtNam,
                decoration: const InputDecoration(
                  label: Text('Năm sinh'),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtQueQuan,
                decoration: const InputDecoration(
                  label: Text('Quê quán'),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (see == true) {
                        Navigator.pop(context);
                      } else {
                        _update(context);
                        // Navigator.pop(context);
                      }
                    },
                    child: Text(btnLabel),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  see == true
                      ? const SizedBox(
                          width: 0,
                        )
                      : ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Hủy'),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _chonAnh(BuildContext context) async {
    xImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xImg != null) {
      setState(() {
        imageChange = true;
      });
    }
  }

  void _update(BuildContext context) async {
    showSnackbar(context, 'Đang cập nhật dữ liệu', 300);
    var sv = SinhVien(
      id: txtId.text,
      ten: txtTen.text,
      que_quan: txtQueQuan.text,
      lop: txtLop.text,
      nam: txtNam.text,
      anh: null,
    );

    if (imageChange) {
      debugPrint(imageChange.toString());
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference =
          storage.ref().child('images').child('anh_${sv.id}.jpg');

      UploadTask uploadTask = await _uploadTask(reference, xImg!);
      uploadTask.whenComplete(() async {
        sv.anh = await reference.getDownloadURL();
        if (svSnapShot != null) {
          _updateSinhVien(svSnapShot!, sv);
        } else {
          debugPrint('Them sv moi co anh: ${sv.anh}');
          _addSinhVien(sv);
        }
      }).onError((error, stackTrace) => Future.error('Có lỗi xảy ra'));
    } else {
      debugPrint(imageChange.toString());
      if (svSnapShot != null) {
        sv.anh = svSnapShot!
            .sv!.anh; //Lấy ảnh cũ (hiện tại) gán cho sv vì sv khởi tạo anh=null
        _updateSinhVien(svSnapShot!, sv);
      } else {
        debugPrint('Them SV khong co anh');
        _addSinhVien(sv);
      }
    }
  }

  _updateSinhVien(SinhVienSnapShot svs, SinhVien sv) async {
    svs
        .update(sv)
        .whenComplete(
            () => showSnackbar(context, 'Cập nhật dữ liệu thành công', 3))
        .onError(
          (error, stackTrace) =>
              showSnackbar(context, 'Cập nhật dữ liệu không thành công', 3),
        );
  }

  _addSinhVien(SinhVien sv) async {
    SinhVienSnapShot.add(sv)
        .whenComplete(
            () => showSnackbar(context, 'Cập nhật dữ liệu thành công', 3))
        .onError((error, stackTrace) {
      showSnackbar(context, 'Cập nhật dữ liệu không thành công', 3);
      return Future.error('Lỗi khi thêm');
    });
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile xFile) async {
    final metadata = SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': xFile.path});

    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = reference.putData(await xFile.readAsBytes(), metadata);
    } else {
      uploadTask = reference.putFile(File(xFile.path), metadata);
    }
    return Future.value(uploadTask);
  }
}
