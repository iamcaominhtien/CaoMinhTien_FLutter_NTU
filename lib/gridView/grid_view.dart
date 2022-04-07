import 'package:flutter/material.dart';

import 'fruit_class.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải cứu nông sản'),
      ),
      body: GridView.extent(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
        children: listFruits
            .map(
              (e) => Card(
                elevation: 3,
                shadowColor: Colors.blue,
                child: Column(
                  children: [
                    Image.asset(e.url),
                    Text(e.name),
                    Text(
                      "Giá: ${e.price}/kg",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
