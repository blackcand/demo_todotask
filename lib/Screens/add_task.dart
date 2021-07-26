import 'package:flutter/material.dart';
import 'package:tasks/Blocs/TaskBloc/task_event.dart';
import 'package:tasks/Blocs/TaskBloc/tasks_bloc.dart';
import 'package:tasks/Model/task_model.dart';
import 'package:tasks/Theme/colors.dart';
import 'package:tasks/Utils/format_time.dart';
import 'package:tasks/Utils/random_id.dart';

class AddTaskPage extends StatefulWidget {
  final Tasks tasks;
  final int taskId;
  AddTaskPage({this.tasks, this.taskId});
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDay;
  TextEditingController tittleController = new TextEditingController();
  TextEditingController desController = new TextEditingController();
  String type = "";
  Tasks _tasks;
  Task _task;
  @override
  void initState() {
    if (widget.tasks != null) {
      _tasks = widget.tasks;
      _task = _tasks.tasks.where((item) => item.id == widget.taskId).first;
      type = _task.type;
      tittleController.text = _task.tittle;
      desController.text = _task.desciption;
      currentDay = DateTime.parse(_tasks.date);
    } else {
      type = "Work";
      currentDay = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _task != null ? "UPDATE TASK" : "ADD TASK",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: disabledTextColor.withOpacity(.3)),
                            borderRadius: BorderRadius.circular(15)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          controller: tittleController,
                          onChanged: (value) => {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title here',
                              hintStyle: TextStyle(
                                  color: disabledTextColor.withOpacity(.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                              contentPadding:
                                  EdgeInsets.only(bottom: 13, right: 10)),
                          maxLines: 3,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Vui lòng nhập Tittle";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: disabledTextColor.withOpacity(.3)),
                              borderRadius: BorderRadius.circular(15)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            controller: desController,
                            onChanged: (value) => {},
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Desciption',
                                hintStyle: TextStyle(
                                    color: disabledTextColor.withOpacity(.5),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                                contentPadding:
                                    EdgeInsets.only(bottom: 13, right: 10)),
                            maxLines: 5,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Filter",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = "Work";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: redColor,
                                border: type == "Work"
                                    ? Border.all(color: Colors.black)
                                    : null,
                                boxShadow: type == "Work"
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.4),
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                          offset: Offset(4, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              width: 100,
                              height: 80,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 15, bottom: 10),
                                  child: Text(
                                    "Work",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = "Home";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: blueColor,
                                border: type == "Home"
                                    ? Border.all(color: Colors.black)
                                    : null,
                                boxShadow: type == "Home"
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.4),
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                          offset: Offset(4, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              width: 100,
                              height: 80,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 15, bottom: 10),
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = "Personal";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: mainColor,
                                border: type == "Personal"
                                    ? Border.all(color: Colors.black)
                                    : null,
                                boxShadow: type == "Personal"
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.4),
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                          offset: Offset(4, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              width: 100,
                              height: 80,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 15, bottom: 10),
                                  child: Text(
                                    "Personal",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 30,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: _task == null
                              ? () async {
                                  final DateTime picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendar);
                                  if (picked != null && picked != currentDay)
                                    setState(() {
                                      currentDay = picked;
                                    });
                                }
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black45))),
                                width: 50,
                                child: Text(
                                  currentDay.day.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black45))),
                                width: 50,
                                child: Text(
                                  currentDay.month.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black45))),
                                width: 50,
                                child: Text(
                                  currentDay.year.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                child: Center(
                    child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mainColor),
                      height: 48,
                      width: MediaQuery.of(context).size.width * .6,
                      child: Center(
                        child: Text(
                          _task != null ? "UPDATE TASK" : "ADD TASK",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  onTap: () {
                    // print("===== ${currentDay.toString()}");
                    bool isFormKey = _formKey.currentState.validate();
                    if (isFormKey) {
                      if (_task == null) {
                        Tasks tasks =
                            new Tasks(date: formatTime(currentDay), tasks: [
                          new Task(
                            id: generateID(),
                            tittle: tittleController.text,
                            desciption: desController.text,
                            type: type,
                            isComplete: false,
                          )
                        ]);
                        TaskBloc.taskBloc.eventController.sink
                            .add(AddTask(tasks));
                      } else {
                        // _task.tittle
                        int index = _tasks.tasks.indexOf(_task);
                        _tasks.tasks[index].tittle = tittleController.text;
                        _tasks.tasks[index].desciption = desController.text;
                        _tasks.tasks[index].type = type;
                        TaskBloc.taskBloc.eventController.sink
                            .add(UpdateTask(_tasks));
                      }

                      Navigator.pop(context);
                    }
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
