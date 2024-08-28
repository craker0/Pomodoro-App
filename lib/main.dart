// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: PomodoroApp(),
    );
  }
}

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  bool isRuning = false;
  Duration duration = Duration(minutes: 25);
  Timer? repeatedFuncation;

  startTimer() {
    repeatedFuncation = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newSec = duration.inSeconds - 1;
        duration = Duration(seconds: newSec);
        if (newSec == 0) {
          repeatedFuncation!.cancel();
          isRuning = false;
          duration = Duration(minutes: 25);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 56, 71),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 32, 41),
        centerTitle: true,
        title: Text(
          "Pomodoro App",
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120,
              lineWidth: 10.0,
              percent: duration.inMinutes/25,
              animation: true,
                animateFromLastPercent: true,
                animationDuration: 1200,
              center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: TextStyle(color: Colors.white, fontSize: 70)),
              progressColor: Colors.blue,
            ),
            SizedBox(
              height: 35,
            ),
            isRuning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (repeatedFuncation!.isActive) {
                                repeatedFuncation!.cancel();
                              } else {
                                startTimer();
                              }
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 110, 28, 8)),
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.fromLTRB(25, 8, 25, 8))),
                          child: Text(repeatedFuncation!.isActive ?"Stop":"Resume",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 226, 226, 226),
                                  fontSize: 27))),
                      SizedBox(
                        width: 17,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            repeatedFuncation!.cancel();
                            setState(() {
                              isRuning = false;
                              duration = Duration(minutes: 25);
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 110, 28, 8)),
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.fromLTRB(25, 8, 25, 8))),
                          child: Text("Cancel",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 226, 226, 226),
                                  fontSize: 27))),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      isRuning = true;
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            const Color.fromARGB(255, 8, 110, 102)),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.fromLTRB(25, 8, 25, 8))),
                    child: Text("Start Studying",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 226, 226, 226),
                            fontSize: 27))),
          ],
        ),
      ),
    );
  }
}
