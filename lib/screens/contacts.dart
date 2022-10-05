import 'dart:ffi';

import 'package:flutter/material.dart';


class ContactsScreen extends StatefulWidget {

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}
void AddContact (ctx){
  showModalBottomSheet(
      isScrollControlled: true,

      context: ctx,
  builder: (ctx){
    return Container(
      width: double.infinity,
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text('Add Contact',style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            Form(child: Column(
              children: [
                TextFormField()
              ],
            ) )

          ],
        ),
      ),
    );
  }
  );

}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
           backgroundColor: Theme.of(context).primaryColor,
           child: IconButton(
             onPressed: (){AddContact(context);},

             icon: Icon(

                 Icons.add,color: Colors.white,

             ),
           ),
         ),
         body: Container(
           child: Text('hello'
               ''),
         ),
    );
  }
}
