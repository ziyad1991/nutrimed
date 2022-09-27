import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/visit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class VisitsProvider with ChangeNotifier {
    String userId;

   void updateAuth ( String uid) {

    this.userId = uid;
    notifyListeners();

   }


   List _tasks = [];
   VisitsProvider(this.userId,this._tasks);

  List<Task> get tasks {

    _tasks.sort((a, b){

      return a.status.compareTo(b.status);

      //softing on numerical order (Ascending order by Roll No integer)
    });
    return [..._tasks];
  }




  Future<void> getTasks() async {
    print('getting tasks');


try {
  var url =
  Uri.parse(
      "https://onsitetracking.trottedmedia.com/api/visits.php?method=select&userid=$userId");
  final response = await http.get(url);
  final extractedData = json.decode(response.body) as Map<String, dynamic>;
  final List<Task> loadedData = [];
  extractedData.forEach((taskId, taskData) {


    loadedData.add(Task(
        visitId: taskId,

        contactName: taskData['contact'],
        address: taskData['address'],
        checkInLat: taskData['checkInLat'],

        checkInLong: taskData['checkInLong'],

        checkInTime: taskData['intime'],
        checkoutLong: taskData['checkoutLong'],
        checkoutLat: taskData['checkoutLat'],
        checkOutTime: taskData['outtime'],
        report: taskData['report'],
        reportdate: taskData['reportdate'],
        visitDate: DateTime.parse(taskData['visitdate']),
        status: taskData['visitstatus']));
  });

  _tasks = loadedData;
  print(loadedData[0].visitDate.month);
  print('i am here');
  notifyListeners();
}catch(e) {

  print(e);
}


  }

  int getCountByType({String theStatus , DateTime date }) {
    if(theStatus == 'ALL'){
      List TaskbyStatus =
      tasks.where((element) => element.visitDate == date).toList();
      int Itemscount = TaskbyStatus.length;
      return Itemscount;

    }else {
      List TaskbyStatus =
      tasks.where((element) => element.status == '$theStatus' && element.visitDate == date).toList();
      int Itemscount = TaskbyStatus.length;
      return Itemscount;

    }


  }
  int getCount() {

    int Itemscount = _tasks.length;

    return Itemscount;
  }
  String getTasktype(String theid) {

    Task filetrdTasks = tasks.firstWhere((element) => element.visitId == theid);

    return '1';


  }
  List  tasksbyType(String type){
    List filetrdTasks = tasks.where((element) => element.status == type).toList();
    return filetrdTasks;

  }


    List  tasksbydate(DateTime date){
      List filetrdTasks = tasks.where((element) => element.visitDate == date
      ).toList();
      return filetrdTasks;

    }
    List  tasksByMonth(String date){
    List filteredTasks = tasks.where((element) => element.visitDate.month.toString()

           ==  date





      ).toList();
      return filteredTasks;

    }
  Task  tasksbyId(String id){
    Task filetrdTasks = tasks.firstWhere((element) => element.visitId == id);
    return filetrdTasks;

  }


  Future <void>  taskUpdate(String id, Task updatedTask,var type,String report,[File uploadedImage]) async {


    final filetrdTasks = tasks.indexWhere((element) => element.visitId == id);

    if (filetrdTasks >= 0) {
      if (type == 'checkIn') {
        List<int> imageBytes = uploadedImage.readAsBytesSync();
        String baseimage = base64Encode(imageBytes);
        final url =
        Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");

        final response = await http.post(url,
            body: json.encode({'type': 'checkIn',
              'taskId': id,
              'checkInLat': updatedTask.checkInLat,
              'checkInLong': updatedTask.checkInLong,
              'image' : baseimage
            }));

        print('hello');
        print(response.body);


        _tasks[filetrdTasks] = updatedTask;

        await getTasks();

        notifyListeners();
      } else if (type == 'checkOut') {
        final url =
        Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");

        final response = await http.post(url,
            body: json.encode({'type': 'checkOut',
              'taskId': id,
              'checkOutLat': updatedTask.checkoutLat,
              'checkOutLong': updatedTask.checkoutLong}));


        _tasks[filetrdTasks] = updatedTask;
        await getTasks();


        notifyListeners();
      }
      else {
        print(report);
        final url =
        Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");
print(updatedTask.report);
        final response = await http.post(url,
            body: json.encode({
              'type': 'report',
              'taskId': id,
              'report': report,
            }));


        _tasks[filetrdTasks] = updatedTask;

        await getTasks();

        notifyListeners();
      }
    }
  }}
