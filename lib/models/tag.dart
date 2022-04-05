import 'package:shared_preferences/shared_preferences.dart';

class Tag {
  final String name;

  Tag({
    required this.name,
  });

  @override
  String toString() => name;
}

List<Tag> tagList = [];

List<String> toStringTagList(List<Tag> data) {
  List<String> ret = [];
  for (int i = 0; i < data.length; i++) {
    ret.add(data[i].toString());
  }
  return ret;
}

List<Tag> toListTagList(List<String> data) {
  List<Tag> ret = [];
  for (int i = 0; i < data.length; i++) {
    var list = data[i];
    ret.add(Tag(name: list));
  }
  return ret;
}

saveTagData() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'TagData';
  final value = toStringTagList(tagList);
  prefs.setStringList(key, value);
}
