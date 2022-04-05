import 'package:flutter/material.dart';
import 'package:flutter_ex/components/rest_timer.dart';
import 'package:flutter_ex/models/work.dart';
import 'package:flutter_ex/screens/setting_screen.dart';
import 'package:flutter_ex/models/tag.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

late String date;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '간단한 운동기록',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//로컬에 있는 데이터를 읽는 함수
  void _readListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = 'WorkData';
    var value = prefs.getStringList(key);
    setState(() {
      workLists = toListDataList(value!);
    });
  }

  void _readTagData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = 'TagData';
    var value = prefs.getStringList(key);
    setState(() {
      tagList = toListTagList(value!);
    });
  }

  @override
  void initState() {
    super.initState();
    _readListData();
    _readTagData();
    var now = DateTime.now();
    String formatDate = DateFormat('MM/dd').format(now);
    date = formatDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        onPressed: () {
          setState(() {
            workLists.add(
              WorkData(
                work: '운동',
                kg: '0',
                reps: '0',
                time: '0',
              ),
            );
            saveListData();
          });
          saveListData();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          date,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const SettingScreen(),
                transition: Transition.noTransition,
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(workLists.length, (index) {
              return Card(index: index);
            }),
          ),
        ),
      ),
    );
  }
}

class Card extends StatefulWidget {
  const Card({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        scrollable: true,
                        title: const Text('운동'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _workController,
                              onChanged: (String value) {
                                setState(() {
                                  workLists[widget.index].work = value;
                                  saveListData();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: workLists[widget.index].work,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(tagList.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      // 이렇게 바꾸고 '스쿼트' 이거는 리스트[0].name 로 써보자.
                                      workLists[widget.index].work =
                                          tagList[index].name;
                                      saveListData();
                                      _workController.clear();
                                      Get.back();
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Ink(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      tagList[index].name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      workLists[widget.index].work,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('kg'),
                        content: TextField(
                          controller: _kgController,
                          onChanged: (String value) {
                            setState(() {
                              workLists[widget.index].kg = value;
                              saveListData();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: workLists[widget.index].kg,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${workLists[widget.index].kg} kg',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('reps'),
                        content: TextField(
                          controller: _repsController,
                          onChanged: (String value) {
                            setState(() {
                              workLists[widget.index].reps = value;
                              saveListData();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: workLists[widget.index].reps,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${workLists[widget.index].reps} reps',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        RestTimer(index: widget.index),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
