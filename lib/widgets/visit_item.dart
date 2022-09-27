import 'package:flutter/material.dart';
import '../screens/task.dart';


class VisitItem extends StatefulWidget {

  int Listnumber;
  var visit;
  String type;

  VisitItem(this.Listnumber,this.visit);
  @override
  _VisitItemState createState() => _VisitItemState();
}

class _VisitItemState extends State<VisitItem> {
  Color color;
  IconData icon;
  String status;
  @override
  Widget build(BuildContext context) {
  String visitId =     widget.visit[widget.Listnumber -1 ].visitId;
  String visitsType =     widget.visit[widget.Listnumber -1 ].status;


    if(visitsType == '1') {
      status= 'New';
      color = Colors.blue;
      icon = Icons.label_important_rounded;

    }else if(visitsType == '3'){
      status= 'Completed';

      color =  Colors.green;
      icon = Icons.done_all_rounded;

    }else if(visitsType == '2'){
      status= 'in progress';

      color =  Colors.purple;
      icon = Icons.update_rounded;

    }else {
      status= 'Archived';

      color =  Colors.grey;
      icon = Icons.archive;

    }



    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: Card(
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              style: BorderStyle.none,
              width: 0.6,

              color: Theme.of(context).primaryColor
          ),
        ),
        elevation: 10,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(
                      arguments:visitId,


                    ),
                    builder:(context){

                  return TaskScreen();

                }));
              },
              leading: CircleAvatar(
                child: Text(widget.visit[widget.Listnumber -1 ].visitId,style: TextStyle(
                  color: Colors.white
                ),),
                  backgroundColor:color ,
              ),
              title: Text(widget.visit[widget.Listnumber -1 ].contactName.toString()),
              subtitle: Text('Assigned to Dr Zaki'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon,color:color,size: 30,),
                  Text(status,style: TextStyle(
                    fontSize: 7
                  ),)
                ],
              )


            )
          ],
        ),
      ),
    );
  }
}
