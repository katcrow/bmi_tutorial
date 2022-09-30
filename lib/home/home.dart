import 'dart:math';

import 'package:crow_bmi_tutorial/home/score_screen.dart';
import 'package:crow_bmi_tutorial/widgets/age_weight_widget.dart';
import 'package:crow_bmi_tutorial/widgets/gender_widget.dart';
import 'package:crow_bmi_tutorial/widgets/height_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GenderWidget(onChange: (genderVal) {
                  _gender = genderVal;
                }),
                HeightWidget(
                  onChange: (heightVal) {
                    _height = heightVal;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AgeWeightWidget(
                      onChange: (ageVal) {
                        // todo
                        _age = ageVal;
                      },
                      title: 'Age',
                      initValue: 30,
                      min: 0,
                      max: 110,
                    ),
                    AgeWeightWidget(
                      onChange: (weightVal) {
                        // todo
                        _weight = weightVal;
                      },
                      title: 'Weight(kg)',
                      initValue: 50,
                      min: 0,
                      max: 200,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      await Navigator.push(context, PageTransition(child: ScoreScreen(
                          bmiScore: _bmiScore, age: _age), type: PageTransitionType
                          .fade,));
                      setState(() {
                        _isFinished = false;
                      });
                    },
                    onWaitingProcess: () {
                      // calculate BMI here
                      calculateBmi();

                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          _isFinished = true;
                        });
                      },);
                    },
                    activeColor: Colors.blue,
                    buttonWidget: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    buttonText: "CALCULATE",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
    // print(_bmiScore);
  }
}
