import 'dart:math';
import 'package:flutter/material.dart';

class Fruit {
  late String name;
  late double price;
  late String url;

  Fruit(this.name, this.price, this.url);
}

var listFruitNames = [
  'apple',
  'banana',
  'kiwi',
  'lemon',
  'orange',
  'watermelon'
];
var listFruits = listFruitNames.map((e) =>
    Fruit(e, Random().nextInt(21000) + 12000, 'assets/gridView/' + e + '.png'));
// var listFruitCards = listFruits
//     .map((e) => Card(
//           elevation: 1,
//           shadowColor: Colors.blue,
//           child: Column(
//             children: [
//               Image.asset('assets/gridView/${e.url}'),
//               Text(e.name),
//               Text(
//                 "Gía: ${e.price}/kg",
//                 style: const TextStyle(color: Colors.red),
//               ),
//             ],
//           ),
//         ))
//     .toList();
