import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class OCR extends StatefulWidget {
  const OCR({super.key});

  @override
  State<OCR> createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OCR'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 102, 160, 241),
                  boxLeftOff: 5,
                  boxBottomOff: 2.5,
                  boxRightOff: 5,
                  boxTopOff: 2.5,
                  boxHeight: MediaQuery.of(context).size.height / 3,
                  getRawData: (value) {
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }),
              StreamBuilder<String>(
                stream: controller.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Result(
                      text: snapshot.data != null ? snapshot.data! : "");
                },
              )
            ],
          ),
        ));
  }
}

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          debugPrint(text);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
          if (text.length > 4) {
            Navigator.pop(context, text.substring(text.length - 4));
          }
          if (text.length < 4) {
            Navigator.pop(context, "");
          }
        },
        child: text.isEmpty ? const Text('Return') : Text('Read Data $text'));
  }
}
