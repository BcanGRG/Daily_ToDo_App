import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_demo/core/data/local_storage.dart';
import 'package:todo_app_demo/core/models/task_model.dart';
import 'package:todo_app_demo/core/theme/styles.dart';
import 'package:todo_app_demo/core/widgets/task_list_item.dart';
import 'package:todo_app_demo/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  late LocalStorage _localStorage;

  @override
  void initState() {
    // TODO: implement initState
    _localStorage = Locator.locator<LocalStorage>();
    _allTasks = [];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Bugün Neler Yapacaksın?",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _currentTask = _allTasks[index];
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        Text(
                          "Bu Görev Silindi",
                          style: MyThemeStyle.taskDismissedTextStyle,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (_) async {
                    _allTasks.removeAt(index);
                    await _localStorage.deleteTask(task: _currentTask);
                    setState(() {});
                  },
                  key: Key(_currentTask.id),
                  child: TaskItem(task: _currentTask),
                );
              },
              itemCount: _allTasks.length,
            )
          : Center(child: Text("Hadi görev ekle")),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: MyThemeStyle.modelBottomSheetShape,
        context: context,
        builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ListTile(
                title: TextField(
                  autofocus: true,
                  style: TextStyle(fontSize: 20.0),
                  decoration: MyThemeStyle.textFieldInputDecoration,
                  onSubmitted: (value) {
                    print(value);
                    Navigator.pop(context);
                    if (value.length > 3) {
                      DatePicker.showTimePicker(context,
                          showSecondsColumn: false,
                          locale: LocaleType.tr, onConfirm: (time) async {
                        var yeniEklenecekGorev =
                            Task.create(name: value, createdAt: time);
                        _allTasks.add(yeniEklenecekGorev);
                        await _localStorage.addTask(task: yeniEklenecekGorev);
                        setState(() {});
                      });
                    }
                  },
                ),
              ),
            ),
          );
        });
  }

  void _getAllTaskFromDb() async {
    _allTasks = await _localStorage.getAllTask();
    setState(() {});
  }
}
