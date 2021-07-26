import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasks/Blocs/TaskBloc/task_event.dart';
import 'package:tasks/Blocs/TaskBloc/task_state.dart';
import 'package:tasks/Blocs/TaskBloc/tasks_bloc.dart';
import 'package:tasks/Model/task_model.dart';
import 'package:tasks/Screens/add_task.dart';
import 'package:tasks/Screens/component/widged.dart';
import 'package:tasks/Theme/colors.dart';
import 'package:tasks/Utils/format_time.dart';
// import 'package:tasks/Utils/random_id.dart';

class HomeTasks extends StatefulWidget {
  @override
  _HomeTasksState createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  // final bloc = TaskBloc();
  CalendarController calendarController = CalendarController();
  DateTime _chosenDate = DateTime.now();
  @override
  void initState() {
    TaskBloc.taskBloc.eventController.sink.add(GetTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home Tasks",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  renderProcessTask(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ))),
                    child: Text(
                      "Today",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  card(
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: TableCalendar(
                          initialSelectedDay: _chosenDate,
                          calendarStyle: CalendarStyle(
                            selectedColor: mainColor,
                            selectedStyle: TextStyle(color: Color(0xFF616161)),
                            highlightToday: false,
                            weekdayStyle: TextStyle(color: Color(0xFF616161)),
                            weekendStyle: TextStyle(color: Color(0xFF616161)),
                          ),
                          initialCalendarFormat: CalendarFormat.week,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarController: calendarController,
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekendStyle:
                                  TextStyle(color: Color(0xFF616161))),
                          onDaySelected: (day, events, holidays) {
                            setState(() {
                              _chosenDate = day;
                            });
                          },
                          headerVisible: true),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: renderListTask(),
                  )
                ],
              ),
            ),
            Container(
              height: 80,
              child: Center(
                  child: GestureDetector(
                child: Icon(
                  Icons.add_circle,
                  size: 60,
                  color: mainColor,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskPage()),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  renderProcessTask() {
    return Container(
      child: StreamBuilder(
        stream: TaskBloc.taskBloc.stateProcessController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TasksState taskData = snapshot.data;
            if (taskData.tasks.length > 0) {
              int index = taskData.tasks.indexWhere(
                  (item) => item.date == formatTime(_chosenDate).toString());
              int taskInDay = 0;
              int taskDoneInDay = 0;
              if (index != -1) {
                taskInDay = taskData.tasks[index].tasks.length;
                taskData.tasks[index].tasks.forEach((item) {
                  if (item.isComplete) taskDoneInDay++;
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    index == -1
                        ? "0/0 tasks"
                        : "$taskDoneInDay/$taskInDay tasks completed",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  index != -1
                      ? Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .7,
                              height: 8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[300]),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  .7 *
                                  taskDoneInDay /
                                  taskInDay,
                              height: 8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.blue[700],
                                        Colors.blue[300],
                                      ],
                                      begin: FractionalOffset.centerLeft,
                                      end: FractionalOffset.centerRight,
                                      tileMode: TileMode.repeated)),
                            ),
                          ],
                        )
                      : Container()
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "0/0 tasks",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  renderListTask() {
    return Container(
      child: StreamBuilder(
        stream: TaskBloc.taskBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TasksState taskData = snapshot.data;

            if (taskData.tasks.length > 0) {
              int index = taskData.tasks
                  .indexWhere((item) => item.date == formatTime(_chosenDate));
              return index == -1
                  ? Container()
                  : ListView.builder(
                      itemCount: taskData.tasks[index].tasks.length,
                      itemBuilder: (context, pos) {
                        Task task = taskData.tasks[index].tasks[pos];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTaskPage(
                                          tasks: taskData.tasks[index],
                                          taskId: task.id,
                                        )),
                              );
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: card(
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              task.isComplete =
                                                  !task.isComplete;
                                              TaskBloc
                                                  .taskBloc.eventController.sink
                                                  .add(UpdateTask(
                                                      taskData.tasks[index]));
                                            },
                                            child: Icon(
                                              !task.isComplete
                                                  ? Icons
                                                      .panorama_fish_eye_outlined
                                                  : Icons.done,
                                              size: 60,
                                              color: mainColor,
                                            )),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      size: 14,
                                                      color: task.type == "Work"
                                                          ? redColor
                                                          : task.type == "Home"
                                                              ? blueColor
                                                              : mainColor,
                                                    ),
                                                    Text(
                                                      task.tittle ?? "",
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  task.desciption ?? "",
                                                  style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: 30,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                              onTap: () {
                                                TaskBloc.taskBloc
                                                    .eventController.sink
                                                    .add(DeleteTask(task));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 24,
                                                  color: Color(0xFF616161),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )));
                      },
                    );
            } else {
              return Container();
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
