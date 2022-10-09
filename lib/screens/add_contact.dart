import 'package:flutter/material.dart';


class AddContactScreen extends StatefulWidget {

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}
String dropdownValue = 'Dog';

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Contact Full Name',
                    labelText: 'Name *',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
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
                    icon: Icon(Icons.build),
                    hintText: 'Contact Type',
                    labelText: 'Phone *',
                  ),
                  items: <String>['Dog', 'Cat', 'Tiger', 'Lion'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                )


                 ],
                ),

        ),
            )
            ]
        ),
      ),
    );
  }
}
