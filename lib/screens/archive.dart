import 'package:flutter/material.dart';
import '../provider/visits_provider.dart';
import '../widgets/visit_item.dart';
import 'package:provider/provider.dart';




class ArchiveScreen extends StatefulWidget {

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();

}

List <String>months = [ 'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'];


String dropdownValue = months.first;
class _ArchiveScreenState extends State<ArchiveScreen> {

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
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks In This Month',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        ' ${(VisitData.tasksByMonth((months.indexOf(dropdownValue) +1).toString()).length.toString())}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional(0,10),
                value: dropdownValue,
                icon:  Icon(Icons.calendar_month,color: Theme.of(context).primaryColor),
                elevation: 16,
                style: TextStyle(color: Colors.black ),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (String value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
        ),
              ),
            ],
          ),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                ],
              ),
            ),
            Expanded(child:
            Consumer<VisitsProvider>(builder: (ctx, visitslist, _) {
              return visitslist.tasksByMonth((months.indexOf(dropdownValue) +1).toString()).isEmpty ? Center(
                child: Text('No Tasks For This Month'),
              ) :   ListView.builder(
                  itemCount: visitslist.tasksByMonth((months.indexOf(dropdownValue) +1).toString()).length,
                  itemBuilder: (ctx, index) =>
                      VisitItem(

                          index + 1, visitslist.tasksByMonth((months.indexOf(dropdownValue) +1).toString()))



              );
            }))

          ],
        )
    );
  }
}
