import 'dart:math';

import 'package:flutter/material.dart';

import 'result_screen/result_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: const Text('Vocabulary Training for kid'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controller = TextEditingController();

  List<Image> img = [
    Image.asset('images/apple.png'),
    Image.asset('images/banana.jpg'),
    Image.asset('images/cow.jpg'),
    Image.asset('images/dog.jpg'),
    Image.asset('images/mango.jpg'),
    Image.asset('images/mouse.jpg'),
    Image.asset('images/orange.jpg'),
    Image.asset('images/pig.webp'),
    Image.asset('images/f.webp'),
  ];

  List<String> correctAnswer = [
    "APPLE",
    "BANANA",
    "COW",
    "DOG",
    "MANGO",
    "MOUSE",
    "ORANGE",
    "PIG",
    "FISH"
  ];

  // List<String> correctButton1 = ["A", "P", "L", "E"];
  // List<String> correctButton2 = ["B", "A", "N"];
  // List<String> correctButton3 = ["C", "O", "W"];
  // List<String> correctButton4 = ["D", "O", "G"];
  // List<String> correctButton5 = ["M", "A", "N", "G", "O"];
  // List<String> correctButton6 = ["M", "O", "U", "S", "E"];
  // List<String> correctButton7 = ["O", "R", "A", "N", "G", "E"];
  // List<String> correctButton8 = ["P", "I", "G"];
  // List<String> correctButton9 = ["F", "I", "S", "H"];

  List<String> possibleButton = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  List<String> getPossibleButton(List<String> correctAnswer) {
    List<String> result = correctAnswer;
    while (result.length < 10) {
      result.add(getRandomString());
    }
    result.shuffle();
    return result;
  }

  String getRandomString() {
    String result = "";
    while (result.isEmpty) {
      String randomChar = possibleButton[Random().nextInt(26)];
      result = randomChar;
    }
    return result;
  }

  void insertButton(String value) {
    controller.text = '${controller.text}$value';
  }

  int incresement = 0;
  int mark = 0;

  void next() {
    if (incresement <= correctAnswer.length - 1) {
      if (controller.text.toLowerCase() ==
          correctAnswer[incresement].toLowerCase()) {
        mark += 1;
      }
    }
    if (controller.text == "") {
      return;
    } else if (incresement < img.length - 1) {
      incresement++;
      controller.text = "";
    } else {
      incresement = 0;
      controller.text = "";
      //setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                  correctResult: mark,
                )),
      );
    }

    setState(() {});
  }

  void delete() {
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              width: 250,
              height: 250,
              child: img[incresement]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: controller,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "   Please  Answer",
                  hintStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)
                  // border: OutlineInputBorder(),
                  ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 150,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 5,
              children: getPossibleButton(correctAnswer[incresement].split(''))
                  .map(
                    (e) => ElevatedButton(
                      onPressed: () {
                        insertButton(e);
                      },
                      child: Text(
                        e,
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                onPressed: delete,
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                onPressed: next,
                child: Text(
                  "Next >>",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
