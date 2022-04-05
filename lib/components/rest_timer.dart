import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_ex/models/work.dart';

class RestTimer extends StatefulWidget {
  RestTimer({
    Key? key,
    required this.index,
  }) : super(key: key);
  final index;

  @override
  State<RestTimer> createState() => _RestTimerState();
}

class _RestTimerState extends State<RestTimer> {
  late Timer _timer;
  var _time = 0;
  var _isRunning = false;

  void _click() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _time++;
        workLists[widget.index].time = _time.toString();
      });
    });
  }

  void _pause() {
    _timer.cancel();
    workLists[widget.index].time = _time.toString();
    saveListData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _click();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.watch_later_outlined,
              size: 16,
            ),
            Text(' ${workLists[widget.index].time}s'),
          ],
        ),
      ),
    );
  }
}
