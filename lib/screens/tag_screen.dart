import 'package:flutter/material.dart';
import 'package:flutter_ex/models/tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  void _readTagData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = 'TagData';
    var value = prefs.getStringList(key);
    setState(() {
      tagList = toListTagList(value!);
    });
  }

  final TextEditingController _tagController = TextEditingController();

  late String newTag;

  @override
  void initState() {
    _readTagData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          controller: _tagController,
          onChanged: (value) {
            setState(() {
              newTag = value;
            });
          },
          decoration: const InputDecoration(
            hintText: '태그 추가',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                tagList.add(Tag(name: newTag));
              });
              saveTagData();
              _tagController.clear();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '클릭해서 삭제',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(tagList.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        tagList.removeAt(index);
                        saveTagData();
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
            ),
          ],
        ),
      ),
    );
  }
}
