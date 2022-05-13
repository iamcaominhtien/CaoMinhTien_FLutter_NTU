import 'package:caominhtien_61cntt2/homework6/cpu_z/components/my_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import '../components/alert_dialog.dart';
import '../components/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactePage extends StatefulWidget {
  const ContactePage({Key? key}) : super(key: key);

  @override
  State<ContactePage> createState() => _ContactePageState();
}

class _ContactePageState extends State<ContactePage> {
  Future<MyContact>? contact;

  @override
  void initState() {
    super.initState();
    setState(() {
      contact = pickContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyContact>(
        future: contact,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("ERROR"),
            );
          } else {
            var data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_box,
                      size: 200,
                    ),
                    Text(
                      data!.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCard(
                          onTap: () async {
                            var canLaunch = await openSMS(data.phone);
                            debugPrint(canLaunch.toString());
                            if (!canLaunch) {
                              showMyDialog(context,
                                  "Bạn chưa cài đặt ứng dụng nhắn tin");
                            }
                          },
                          titleButton: "message",
                          icon: Icons.message,
                        ),
                        MyCard(
                          onTap: () async {
                            var canLaunch = await openPhoneDial(data.phone);
                            debugPrint(canLaunch.toString());
                            if (!canLaunch) {
                              showMyDialog(context,
                                  "Bạn chưa cài đặt ứng dụng gọi điện");
                            }
                          },
                          titleButton: "call",
                          icon: Icons.call,
                        ),
                        MyCard(
                          onTap: () async {
                            var canLaunch = await sendEmail(data.phone);
                            debugPrint(canLaunch.toString());
                            if (!canLaunch) {
                              showMyDialog(
                                  context, "Bạn chưa cài đặt ứng dụng Email");
                            }
                          },
                          titleButton: "email",
                          icon: Icons.email,
                        ),
                      ],
                    ),
                    MyCardLong(
                      onTap: () async {
                        var canLaunch = await openPhoneDial(data.phone);
                        debugPrint(canLaunch.toString());
                        if (!canLaunch) {
                          showMyDialog(
                              context, "Bạn chưa cài đặt ứng dụng gọi điện");
                        }
                      },
                      titleButton: data.phone,
                      headingButton: 'home',
                    ),
                    MyCardLong(
                      onTap: () => gotoWebsite(
                          "https://www.facebook.com/minhtien.cao.35977897/"),
                      titleButton:
                          "https://www.facebook.com/minhtien.cao.35977897/",
                      headingButton: 'website',
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  void gotoWebsite(String url) async {
    String httpUrl = url.startsWith("http") ? url : "http://$url";
    await launchUrl(Uri.parse(httpUrl));
  }

  Future<bool> openPhoneDial(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    bool check = await canLaunchUrl(launchUri);
    if (check) {
      return launchUrl(launchUri);
    }
    return false;
  }

  Future<MyContact> pickContact() async {
    bool permission = await FlutterContactPicker.hasPermission();
    if (permission == false) {
      bool requetsPermission = await FlutterContactPicker.requestPermission();
      if (requetsPermission == true) permission = true;
    }
    if (permission == true) {
      try {
        PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
        String contactName = contact.fullName ?? "No name";
        String phoneNumber = contact.phoneNumber?.number ?? "No Phone";
        String email = "iamcaominhtien@gmai.com";
        return MyContact(name: contactName, phone: phoneNumber, email: email);
      } catch (e) {
        return Future.error('Lỗi khi chọn contact');
      }
    } else {
      return Future.error("Chưa cấp quyền đọc danh bạ");
    }
  }

  Future<bool> openSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    bool check = await canLaunchUrl(launchUri);
    if (check) {
      return launchUrl(launchUri);
    }
    return false;
  }

  Future<bool> sendEmail(String to) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: to,
    );
    bool check = await canLaunchUrl(launchUri);
    if (check) {
      return launchUrl(launchUri);
    }
    return false;
  }
}
