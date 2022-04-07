import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My Image'),
        ),
      ),
      drawer: Container(
        color: Colors.white,
        width: 250,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                height: 200,
                width: 200,
                child: Image.asset('assets/images/snake.jpg'),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                height: 200,
                width: 200,
                child: Image.network(
                  'https://yt3.ggpht.com/Lg0Qyalm3HcLuuwcdz4ZdydPp1KMBlbbSlJMD0ucBa15aArHGPZ5HeCloK46dJFH_rmIX3Ifcg=s900-c-k-c0x00ffffff-no-rj',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  Text('150 đánh giá')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyImage2 extends StatelessWidget {
  const MyImage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Image')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              height: 250,
              width: 250,
              child: Image.asset('assets/images/snake.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                height: 250,
                width: 250,
                child: Image.network(
                  'https://yt3.ggpht.com/Lg0Qyalm3HcLuuwcdz4ZdydPp1KMBlbbSlJMD0ucBa15aArHGPZ5HeCloK46dJFH_rmIX3Ifcg=s900-c-k-c0x00ffffff-no-rj',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: AlignmentDirectional.center
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
            Container(
              width: double.infinity,
            ),
          ],
        ));
  }
}
