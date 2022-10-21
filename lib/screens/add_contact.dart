import 'package:flutter/material.dart';
import '../provider/contacts_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import '../screens/add_location.dart';
import '../models/place.dart';
import 'package:Nutrimed/helpers/location_helper.dart';


import 'dart:async';


class AddContactScreen extends StatefulWidget {

  final Function onSelectPlace;

  AddContactScreen(this.onSelectPlace);
  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();

  String ContactName = '';
  String ContactPhone = '1';
  String ContactType = '2';
  String ContactAddress = '3';
  String ContactLat ='4';
  String ContactLong ='5';
  bool isLoading = false;

  void AddContact() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<ContactsProvider>(context, listen: false).AddContact(
            ContactName, ContactPhone, ContactAddress, ContactType, ContactLat,
            ContactLong).then((_) =>
            setState(() {
              isLoading = false;
            }));

        final snackBar = SnackBar(
          content: const Text('Contact Added Successfully'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await Provider.of<ContactsProvider>(context,listen: false).getcontacts();



      } catch (e) {
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


      setState(() {
        isLoading = false;
      });
    }
  }

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(31.242452, 29.9690083),
    zoom: 14.4746,
  );

  var textController = TextEditingController();
  // void _showPreview(double lat, double lng) {
  //   final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
  //     latitude: lat,
  //     longitude: lng,
  //   );
  //   setState(() {
  //     _previewImageUrl = staticMapImageUrl;
  //   });
  // }
  String dropdownValue;
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => AddLocation(
          isSelecting: true,
        ),
      ),
    );

    setState(() {
      ContactLat = selectedLocation.latitude.toString();
      ContactLong = selectedLocation.longitude.toString();

    });



    if (selectedLocation == null) {
      return;
    }
    // _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }
  @override
  Widget build(BuildContext context) {
    // print(_pickedLocation.longitude);
   List<String> shello = ['hello','hi'];
    final ContactsType = Provider.of<ContactsProvider>(context).ContactType;
    shello = ContactsType;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),

      ),
       body:isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,

                child: Padding(

              padding: const EdgeInsets.all(20.0),
              child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Contact Full Name',
                    labelText: 'Name *',
                  ),
                  onSaved: (value){

                      ContactName  = value;

                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
    validator: (Name) {
    if (Name.isNotEmpty) return null;
    else
    return 'Enter a valid Name';
    },
                  onSaved: (value){

                    ContactPhone  = value;

                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: 'Contact Phone Number',
                    labelText: 'Phone *',
                  ),

                ),

                DropdownButtonFormField(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },

                  decoration: const InputDecoration(
                    icon: Icon(Icons.attribution_rounded),
                    hintText: 'Contact Type',
                    labelText: 'Type Of Contact *',
                  ),
                  items: shello.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Add Location',style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed:  _selectOnMap,
                            style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                            child: Text("Add Contact Location"),


                          ),
                          ContactLat.isNotEmpty ? Text("Location Added",style: TextStyle(color: Colors.green),) : Text('Location Not Added',style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(

                        onPressed:  AddContact,

                        style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(20)),
                        child: Text("Save Contact"),


                      ),
                    ),
                  ],
                )
    ])
    )
    )
    ])


    )
    );}
}
