import 'package:shared_preferences/shared_preferences.dart';

class WorkData {
  String work;
  String kg;
  String reps;
  String time;
  WorkData({
    required this.work,
    required this.kg,
    required this.reps,
    required this.time,
  });

  @override
  String toString() => work + '/' + kg + '/' + reps + '/' + time;
}

List<WorkData> workLists = [];

// List<ListData>를 List<String>으로 변환해주는 함수
List<String> toStringList(List<WorkData> data) {
  List<String> ret = [];
  for (int i = 0; i < data.length; i++) {
    ret.add(data[i].toString());
  }
  return ret;
}

// List<String>을 List<ListData>으로 변환해주는 함수
List<WorkData> toListDataList(List<String> data) {
  List<WorkData> ret = [];
  for (int i = 0; i < data.length; i++) {
    var list = data[i].split('/');
    ret.add(WorkData(work: list[0], kg: list[1], reps: list[2], time: list[3]));
  }
  return ret;
}

// 로컬에 저장해주는 함수
saveListData() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'WorkData';
  final value = toStringList(workLists);
  prefs.setStringList(key, value);
}

// 읽기는 setState 로 인하여? main 으로 보냄
