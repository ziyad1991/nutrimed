import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../widgets/contact_item.dart';
import '../provider/contacts_provider.dart';
import './add_contact.dart';
import '../models/place.dart';

class ContactsScreen extends StatefulWidget {

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;

  bool _isinit = true;
  bool _isloading = false;

  PlaceLocation _pickedLocation;



  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<ContactsProvider>(context).getcontacts().then((_) {
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



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Theme.of(context).primaryColor,
        onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AddContactScreen(_selectPlace)));
        },
        child: Icon(
          Icons.add
        ),
      ),
        body: _isloading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),) : Container(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(

                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.grey, width: 1.0),
                                color: Theme.of(context).primaryColor,

                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Provider.of<ContactsProvider>(context).ContactByStatus('2').length.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  'Approved',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Container(
                        height: 120,
                        width: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.grey, width: 1.0),
                                color: Colors.green,
                              ),
                            ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Provider.of<ContactsProvider>(context).ContactByStatus('1').length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),

                              Text(
                                'Pending',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),],
                          )

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Expanded(child:
                Consumer<ContactsProvider>(builder: (ctx, visitslist, _) {
                  return visitslist.contactsbydate().isEmpty ? Center(
                    child: Text('No Tasks For This Day'),
                  ) :   ListView.builder(
                      itemCount: visitslist.contactsbydate().length,
                      itemBuilder: (ctx, index) =>
                          ContactItem(

                              index + 1, visitslist.contactsbydate())



                  );
                })),


              ],
            )
        ),
        // floatingActionButton: Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       FloatingActionButton.extended(
        //         heroTag: null,
        //
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.add),
        //         label: Text('Add Visit'),
        //         onPressed: (){
        //           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddVisitScreen()));
        //         },
        //
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       FloatingActionButton.extended(
        //         heroTag: null,
        //
        //
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.add),
        //         label: Text('Add Activity'),
        //         onPressed: (){
        //           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddActivityScreen()));
        //         },
        //
        //       ),
        //     ]
        // )
    );
  }
}
