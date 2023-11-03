import 'package:flutter/material.dart';

import '../../global.dart';

class MusicDetails extends StatefulWidget {
  const MusicDetails({super.key});

  @override
  State<MusicDetails> createState() => _MusicDetailsState();
}

class _MusicDetailsState extends State<MusicDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Name")),
      body: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/icon.png",
              height: height * 0.3,
              width: height * 0.3,
            ),
          ),
        ]),
      ),
    );
  }
}
