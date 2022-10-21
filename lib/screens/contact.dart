import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nutrimed/provider/contacts_provider.dart';
import 'package:Nutrimed/models/contact.dart';



class ContactScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final String ContactId = ModalRoute.of(context).settings.arguments.toString();

    Contact S = Provider.of<ContactsProvider>(context).ContactbyId(ContactId);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.ContactName),
      ),
    );
  }
}
