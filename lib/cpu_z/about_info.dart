import 'package:flutter/material.dart';

class AboutInfo extends StatefulWidget {
  const AboutInfo({Key? key}) : super(key: key);

  @override
  State<AboutInfo> createState() => _AboutInfoState();
}

class _AboutInfoState extends State<AboutInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'CPU-Z',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'for Android',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Version 1.41',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('CPUID CPU-Z is a free software'),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: const [
            AboutInfoButton(label: 'Online Validation'),
            AboutInfoButton(label: 'CPU-Z Settings'),
            AboutInfoButton(label: 'Help and FAQ'),
            AboutInfoButton(label: 'Remove Ads'),
          ],
        ),
        const SizedBox(height: 240),
        Column(
          children: const [
            Text(
              'CPUID Web Page',
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              'Validation Web Page',
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              'Copyright 2021 - CPUID - All Rights Reserved',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    );
  }
}

class AboutInfoButton extends StatelessWidget {
  const AboutInfoButton({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 50),
      child: ElevatedButton(
        onPressed: null,
        child: SizedBox(
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          width: 150,
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                // side: BorderSide(
                //   color: Colors.black,
                //   width: 1,
                //   style: BorderStyle.solid,
                // ),
                borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );
  }
}
