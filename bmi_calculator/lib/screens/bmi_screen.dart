import 'package:flutter/material.dart';

import '../widgets/sliderwidget.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  num _selectedHeight = 50;
  num _selectedWeight = 100;

  void handleHeightChanged(num height) {
    setState(() {
      _selectedHeight = height;
    });
  }

  void _showBMI() {
    // Convert weight from pounds to kilograms
    double weightInKg = _selectedWeight * 0.45359237;

    // Convert height from centimeters to meters
    double heightInM = _selectedHeight / 100;

    // Calculate BMI
    double bmi = weightInKg / (heightInM * heightInM);

    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Your BMI is: ${bmi.toStringAsFixed(2)}"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 3, 70),
        appBar: AppBar(
          elevation: 2,
          backgroundColor: const Color.fromARGB(255, 40, 7, 255),
          title: const Text(
            "BMI Calculator",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 16, top: 32, right: 16, bottom: 16),
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 7, 255),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Height",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${_selectedHeight.toString()} cm",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    BMISlider(
                      onHeightChanged: handleHeightChanged,
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 16),
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 7, 255),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Weight",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${_selectedWeight.toString()} lb",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ElevatedButton(
                                clipBehavior: Clip.none,
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(20, 60),
                                    backgroundColor:
                                        const Color.fromARGB(255, 14, 2, 95),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _selectedWeight = _selectedWeight + 1;
                                  });
                                },
                                child: const Icon(Icons.add)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ElevatedButton(
                                clipBehavior: Clip.none,
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(20, 60),
                                    backgroundColor:
                                        const Color.fromARGB(255, 14, 2, 95),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _selectedWeight = _selectedWeight - 1;
                                  });
                                },
                                child: const Icon(Icons.remove)),
                          ),
                        ])
                  ]),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    _showBMI();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Calculate Your BMI",
                      style: TextStyle(
                        color: Color.fromARGB(255, 15, 3, 73),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}
