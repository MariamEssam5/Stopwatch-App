import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int s = 0, m = 0, h = 0;
  String digsec = "00", digmin = "00", dighr = "00";
  Timer? timer;
  bool started = false;
  List laps = [];
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      s = 0;
      h = 0;
      m = 0;
      dighr = "00";
      digmin = "00";
      digsec = "00";
      started = false;
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsec = s + 1;
      int localmin = m;
      int localhr = h;
      if (localsec > 59) {
        if (localmin > 59) {
          localhr++;
          localmin = 0;
        } else {
          localmin++;
          localsec = 0;
        }
      }
      setState(() {
        m = localmin;
        s = localsec;
        h = localhr;
        digsec = (s >= 10) ? "$s" : "0$s";
        digmin = (m >= 10) ? "$m" : "0$m";
        dighr = (h >= 10) ? "$h" : "0$h";
      });
    });
  }

  void addLaps() {
    String lap = "$dighr:$digmin:$digsec";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color(0xFF1C2657),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "StopWatch App ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF313E66),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$dighr:$digmin:$digsec',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                      // color: Color(0xFF313E66),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap ${index + 1}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              Text(
                                "${laps[index]}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        !started ? start() : stop();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!started) ? "Start" : "Stop",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: Icon(
                        Icons.flag,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: StadiumBorder(),
                    child: Text(
                      "Restart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
