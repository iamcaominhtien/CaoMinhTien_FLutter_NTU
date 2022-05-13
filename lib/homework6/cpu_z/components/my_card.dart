// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.onTap,
    required this.titleButton,
    this.icon,
  }) : super(key: key);
  final VoidCallback onTap;
  final String titleButton;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(titleButton),
        ]),
        // onTap: ()async{
        //   bool check=await canLaunch
        // },
      ),
    );
  }
}

class MyCardLong extends StatelessWidget {
  const MyCardLong({
    Key? key,
    required this.onTap,
    required this.titleButton,
    required this.headingButton,
  }) : super(key: key);
  final VoidCallback onTap;
  final String titleButton;
  final String headingButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: GestureDetector(
        onTap: onTap,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            headingButton,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(titleButton),
        ]),
        // onTap: ()async{
        //   bool check=await canLaunch
        // },
      ),
    );
  }
}
