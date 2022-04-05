import 'package:flutter/material.dart';
import 'package:flutter_ex/main.dart';
import 'package:flutter_ex/models/work.dart';
import 'package:flutter_ex/screens/tag_screen.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => const HomeScreen(),
              transition: Transition.noTransition,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const TagScreen());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: const Center(
                    child: Text('태그 설정하기'),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  // 카드 리스트 빈 배열로 만들어주기.
                  setState(() {
                    workLists = [];
                    saveListData();
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: const Center(
                    child: Text('운동일지 비우기'),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
