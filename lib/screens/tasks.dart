import 'package:flutter/material.dart';
import '../provider/visits_provider.dart';
import '../widgets/visit_item.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

import 'package:provider/provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';


class TasksScreen extends StatefulWidget {

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;

  bool _isinit = true;
  bool _isloading = false;



  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<VisitsProvider>(context).getTasks().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final VisitData = Provider.of<VisitsProvider>(context);



    return Container(

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks for today',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        ' ${(VisitData.getCountByType(theStatus: '1',date: _selectedValue)).toString()} of ${(VisitData.getCountByType(theStatus: 'ALL',date: _selectedValue)).toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ]),
                Container(
                  height: 70,
                  width: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: Colors.grey, width: 1.0),
                          color: Color.fromRGBO(220, 220, 220, 1),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('EEEE').format(_selectedValue).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color:  Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.only(right: 5, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: DatePicker(
                    DateTime(DateTime.now().year, DateTime.now().month , 1),
                    daysCount: daysInMonth(DateTime.now().year, DateTime.now().month ),
                    width: 50,
                    height: 90,
                    controller: _controller,
                    initialSelectedDate: DateTime(DateTime.now().year, DateTime.now().month , DateTime.now().day ),

                    selectionColor:  Theme.of(context).primaryColor,
                    selectedTextColor: Colors.white,


                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;

                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child:
          Consumer<VisitsProvider>(builder: (ctx, visitslist, _) {
            return visitslist.tasksbydate(_selectedValue).isEmpty ? Center(
              child: Text('No Tasks For This Day'),
            ) :   ListView.builder(
                itemCount: visitslist.tasksbydate(_selectedValue).length,
                itemBuilder: (ctx, index) =>
                    VisitItem(

                        index + 1, visitslist.tasksbydate(_selectedValue))



            );
          }))

        ],
      )
    );
  }
}
