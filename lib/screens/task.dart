import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/visits_provider.dart';
import 'package:provider/provider.dart';
import '../models/visit.dart';
import 'package:location/location.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}



class _TaskScreenState extends State<TaskScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  bool checkOutdone = false;
  bool checkIndone = false;
  bool reportdone = false ;
  String report;
  File uploadedImage;

   bool isLoading = false;
  var loadedVisit = Task(
    status : '',
    address: '',
    contactName : '',
    visitId: null,
    checkInTime: '',
    checkInLat: '',
    checkInLong: '',

    checkOutTime: '',
    checkoutLat: '',
    checkoutLong: '',
    report: '',
    reportdate: '',

  );
  var initvalue = {
    'status' : '',

    'address': '',
    'contactName' : '',
    'visitId': null,

   'checkInTime': '',
  'checkInLat' : '',
    'checkInLong' : '',

    'checkOutTime' : '',
 'checkoutLat' : '',
    'checkoutLong' : '',
    'report': '',
    'reportdate': '',


  };

   bool isinit = true;

  void checkIn() async{
    setState(() {
      isLoading = true;

    });

    final ImagePickerx = ImagePicker();
     var imageFile = await ImagePickerx.getImage(source: ImageSource.camera, maxWidth: 300, imageQuality: 100,
      );


    if (imageFile != null) {
    setState(() {
      uploadedImage = File(imageFile.path);


    });




try {
  final Location location =   Location();


  LocationData checkinLocation = await location.getLocation();
  loadedVisit.checkInLat = checkinLocation.latitude.toString();
  loadedVisit.checkInLong = checkinLocation.longitude.toString();

  await Provider.of<VisitsProvider>(context, listen: false).taskUpdate(
      loadedVisit.visitId, loadedVisit, 'checkIn', '', uploadedImage).then((
      _) =>
      setState(() {
        isLoading = false;
        isinit = true;

        checkIndone = true;
      })


  );
  location.enableBackgroundMode(enable: true);
  location.onLocationChanged.listen((LocationData currentLocation) {
    print('location changed');
    String hello = currentLocation.latitude.toString();
    String hello2 = currentLocation.longitude.toString();

  });
  final snackBar = SnackBar(
    content: const Text('Checked In Successfully '),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}catch(e){
  final snackBar = SnackBar(
    content: const Text('Check In failed '),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

    }


    setState(() {
      isLoading = false;

    });


  }
  void checkOut() async{
    setState(() {
      isLoading = true;

    });


    final Location location =   Location();
    LocationData checkinLocation = await location.getLocation();
    loadedVisit.checkoutLat = checkinLocation.latitude.toString();
    loadedVisit.checkoutLong = checkinLocation.longitude.toString();



    await  Provider.of<VisitsProvider>(context,listen: false)
        .taskUpdate(loadedVisit.visitId, loadedVisit, 'checkOut','').then((_) =>
        setState(() {
          isLoading = false;
          isinit = true;

          checkOutdone = true;
        })
    );





  }

  void complete(ctx) async{
   // Navigator.pop(context);
   if(myController.text.isNotEmpty){


     setState(() {
       isLoading = true;
       report =myController.text;
     });

     Navigator.pop(ctx);

     await  Provider.of<VisitsProvider>(context,listen: false)
         .taskUpdate(loadedVisit.visitId, loadedVisit, 'report',report).then((_) =>
         setState(() {
           isLoading = false;
           isinit = true;

           reportdone = true;
         })

    );


   }




  }

  Future uploadFile(){


    FilePicker.platform.pickFiles();
  }
  void finishedTask(ctx){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Theme.of(context).primaryColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:20 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Enter your Report',style: TextStyle(
                      color: Colors.white
                  ),
                  ),
          TextButton.icon(

              onPressed: (){
              uploadFile();

          }, icon: Icon(Icons.add,color: Colors.white,), label: Text('Attach File',style: TextStyle(
            color: Colors.white,fontSize: 10
          ),))


          ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: myController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'The Visit report Details',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                ),
                autofocus: true,
              ),

                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:  MaterialStateProperty.all(Colors.white),
                    ),
                  child: Center(child: const Text('Submit',style: TextStyle(color:  Color.fromRGBO(249, 96, 96, 1)))),
                  onPressed: (){
                      complete(ctx);
                  }
                  ,
                ),
              )
            ],
          ),
        ));
  }
  @override
   var snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  void didChangeDependencies() {
    if (isinit) {
      final String visitId = ModalRoute.of(context).settings.arguments.toString();
   if(visitId.isNotEmpty) {
     loadedVisit = Provider.of<VisitsProvider>(context).tasksbyId(visitId);
     initvalue = {
       'visitId': loadedVisit.visitId,
       'checkInTime': loadedVisit.checkInTime,
       'checkOutTime': loadedVisit.checkOutTime,
       'checkInLat': loadedVisit.checkInLat,
       'checkoutLat': loadedVisit.checkoutLat,
       'address': loadedVisit.address,
       'contactName': loadedVisit.contactName,
       'status': loadedVisit.status,
       'report': loadedVisit.report,
       'reportdate': loadedVisit.reportdate,

     };
   }
   isinit = false;
   if(loadedVisit.checkInTime.isNotEmpty)  {
        setState(() {
          checkIndone = true;
        });
      }
      if(loadedVisit.checkOutTime.isNotEmpty)
        setState(() {
          checkOutdone = true;
        });
    }
    if(loadedVisit.report.isNotEmpty){
      setState(() {
        reportdone = true;

      });
  }
  }
  @override
  Widget build(BuildContext context) {
print(reportdone);
print('yes');


    return Scaffold(
      appBar: AppBar(

        title: Text('Task Id : ' + initvalue['visitId'].toString()),


      ),
      body:  isLoading ? Center(child: CircularProgressIndicator()) : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Card(



                 elevation: 10,
                  child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Visit Contact Name',style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(initvalue['contactName']),
                             SizedBox(height: 3,),
                             Text('Address',style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(initvalue['address']),
                             SizedBox(height: 3,),
                             Text('Note',style: TextStyle(fontWeight: FontWeight.bold),),
                             Text('working hours : 10 am - 10 pm'),
                         ],
                       ),
                     ),

         Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
             (initvalue['status'] == '1') ? Icons.label_important_rounded :(initvalue['status'] == '2')? Icons.update_rounded :(initvalue['status'] == '3') ? Icons.done_all_rounded : Icons.done_all_rounded)


                  ],

         ) ],
                  ),
                        ),


                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
            child: InkWell(
            onTap: checkIndone ?  () {
              final snackBar = SnackBar(
                content: const Text('Already Checked In'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }


              : checkIn ,

              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Column(

                            children: [
                              Text(initvalue['checkInTime'].isEmpty ?  'Check In' : 'Checked In',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(initvalue['checkInTime'].isNotEmpty ? initvalue['checkInTime']  : '',style: TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                              ),),
                             // Text('10:55 am '),

                            ],

                          ),
                          Icon(initvalue['checkInTime'].isEmpty ? Icons.fingerprint : Icons.check_box,size: 50,color: Colors.white,)

                        ],
                      ),
                    )
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      style: BorderStyle.none,
                      width: 0.6,

                      color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
            child: InkWell(
              onTap: checkOutdone ?  () {
                final snackBar = SnackBar(
                  content: const Text('Already Checked Out'),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } : !checkIndone  ? () {
                final snackBar = SnackBar(
                  content: const Text('Check In First'),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }


                  : checkOut ,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Column(

                            children: [
                              Text(initvalue['checkOutTime'].isEmpty  ? 'Check Out' : 'Checked out',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(initvalue['checkOutTime'].isEmpty ? ''  : initvalue['checkOutTime'],style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                              ),),

                            ],

                          ),
                          Icon(initvalue['checkOutTime'].isEmpty ?  Icons.fingerprint : Icons.check_box,size: 50,color: Colors.white,)

                        ],
                      ),
                    )
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      style: BorderStyle.none,
                      width: 0.6,

                      color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
            child: InkWell(
              onTap: reportdone ?  () {
                final snackBar = SnackBar(
                  content: const Text('Already Completed the Task'),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }: !checkOutdone  ? () {
                final snackBar = SnackBar(
                  content: const Text('Check Out First'),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }


                  :(){
                finishedTask(context);
              },

              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(

                            children: [
                              Text(reportdone ?  'Completed' : 'Complete' ,style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(reportdone ?   initvalue['reportdate'] : ''  ,style: TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                              ),),
                              // Text('10:55 am '),

                            ],

                          ),
                          Icon(reportdone ? Icons.check_box : Icons.fingerprint,size: 50,color: Colors.white,)

                        ],
                      ),
                    )
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      style: BorderStyle.none,
                      width: 0.6,

                      color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

