
import 'package:flutter/material.dart';
import './add_contact.dart';


class ContactsScreen extends StatefulWidget {

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}
void AddContact (ctx){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      // isScrollControlled: true,

      context: ctx,
  builder: (ctx){
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),


            child: Column(
              children: [
                Padding(

                  padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                    left: 30,
                    right: 30,
                    top: 20

                  ),



                  child:

                      Form(child: Column(
                        children: [
                          TextFormField(
                            keyboardAppearance: Brightness.dark,
                          ),
                          TextFormField(),TextFormField(),TextFormField(),TextFormField(),TextFormField(),                ],
                      ) ),
                ),
              ],
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
             onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (ctx){
                 return AddContactScreen();
               }));

             },

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
