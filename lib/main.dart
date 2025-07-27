import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/CustomSlider.dart';
import 'package:flutter_application_1/components/PosesTable.dart';
import 'package:flutter_application_1/components/StyledButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Robot Arm Control Panel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _motor1_angle = 90;
  double _motor2_angle = 90;
  double _motor3_angle = 90;
  double _motor4_angle = 90;
  double _motor5_angle = 90;
  List<Map<String, dynamic>> savedPoses = [
    {
      'id': '1',
      'name': 'Home Position',
      'motor1': 90.0,
      'motor2': 90.0,
      'motor3': 90.0,
      'motor4': 90.0,
      'motor5': 90.0,
    },
    // Add more poses as needed
  ];

  void _setMotor1Angle(double angle) {
    setState(() {
      _motor1_angle = angle;
    });
  }

  void _setMotor2Angle(double angle) {
    setState(() {
      _motor2_angle = angle;
    });
  }

  void _setMotor3Angle(double angle) {
    setState(() {
      _motor3_angle = angle;
    });
  }

  void _setMotor4Angle(double angle) {
    setState(() {
      _motor4_angle = angle;
    });
  }

  void _setMotor5Angle(double angle) {
    setState(() {
      _motor5_angle = angle;
    });
  }

  void _applyPose(Map<String, dynamic> pose) {
    setState(() {
      _motor1_angle = pose['motor1'];
      _motor2_angle = pose['motor2'];
      _motor3_angle = pose['motor3'];
      _motor4_angle = pose['motor4'];
      _motor5_angle = pose['motor5'];
    });
  }

  void _deletePose(String id) {
    setState(() {
      savedPoses.removeWhere((pose) => pose['id'] == id);
    });
  }

  void _saveCurrentPose(String name) {
    setState(() {
      savedPoses.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'motor1': _motor1_angle,
        'motor2': _motor2_angle,
        'motor3': _motor3_angle,
        'motor4': _motor4_angle,
        'motor5': _motor5_angle,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomSlider(
              value: _motor1_angle,
              label: "Motor 1",
              onChanged: _setMotor1Angle,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16),
            ),
            CustomSlider(
              value: _motor2_angle,
              label: "Motor 2",
              onChanged: _setMotor2Angle,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16),
            ),
            CustomSlider(
              value: _motor3_angle,
              label: "Motor 3",
              onChanged: _setMotor3Angle,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16),
            ),
            CustomSlider(
              value: _motor4_angle,
              label: "Motor 4",
              onChanged: _setMotor4Angle,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16),
            ),
            CustomSlider(
              value: _motor5_angle,
              label: "Motor 5",
              onChanged: _setMotor5Angle,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StyledButton(
                  text: "Reset",
                  onPressed: () {
                    _setMotor1Angle(90);
                    _setMotor2Angle(90);
                    _setMotor3Angle(90);
                    _setMotor4Angle(90);
                    _setMotor5Angle(90);
                  },
                  isLoading: false,
                ),
                StyledButton(
                  text: "Save Pose",
                  onPressed: () {
                    _saveCurrentPose("Pose ${savedPoses.length + 1}");
                  },
                  isLoading: false,
                ),
                StyledButton(text: "Run", onPressed: () {}, isLoading: false),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // ... your existing sliders and buttons

                  // Add this where you want the table to appear
                  SavedPosesTable(
                    poses: savedPoses,
                    onApply: _applyPose,
                    onDelete: _deletePose,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: null,
    );
  }
}
