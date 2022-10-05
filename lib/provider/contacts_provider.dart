import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class ContactsProvider with ChangeNotifier {
  String userId;

  void updateAuth ( String uid) {

    this.userId = uid;
    notifyListeners();

  }


  List _contacts = [];
  ContactsProvider(this.userId,this._contacts);

  List<Contact> get contacts {

    _contacts.sort((a, b){

      return a.status.compareTo(b.status);

      //softing on numerical order (Ascending order by Roll No integer)
    });
    return [..._contacts];
  }




  Future<void> getcontacts() async {
    print('getting contacts');


    try {
      var url =
      Uri.parse(
          "https://onsitetracking.trottedmedia.com/api/visits.php?method=select&userid=$userId");
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Contact> loadedData = [];
      extractedData.forEach((contactId, contactData) {


        loadedData.add(Contact(
            ContactId: contactId,

            ContactName: contactData['contact'],
            Phone: contactData['phone'],

            Address: contactData['address'],
            Note: contactData['note'],
            Type: contactData['type'],
            Lat: contactData['lat'],
            Long: contactData['long'],
            Status: contactData['status'],
            Adder: contactData['adder'],
            addDate: contactData['addDate'],
        ));
      });

      _contacts = loadedData;
      notifyListeners();
    }catch(e) {

      print(e);
    }


  }

  // int getCountByType({String theStatus , DateTime date }) {
  //   if(theStatus == 'ALL'){
  //     List contactbyStatus =
  //     contacts.where((element) => element.visitDate == date).toList();
  //     int Itemscount = contactbyStatus.length;
  //     return Itemscount;
  //
  //   }else {
  //     List contactbyStatus =
  //     contacts.where((element) => element.status == '$theStatus' && element.visitDate == date).toList();
  //     int Itemscount = contactbyStatus.length;
  //     return Itemscount;
  //
  //   }
  //
  //
  // }
  int getCount() {

    int Itemscount = _contacts.length;

    return Itemscount;
  }
  String getcontacttype(String theid) {

    Contact filetrdcontacts = contacts.firstWhere((element) => element.ContactId == theid);

    return '1';


  }
  List  contactsbyType(String type){
    List filetrdcontacts = contacts.where((element) => element.Status == type).toList();
    return filetrdcontacts;

  }


  // List  contactsbydate(DateTime date){
  //   List filetrdcontacts = contacts.where((element) => element.visitDate == date
  //   ).toList();
  //   return filetrdcontacts;
  //
  // }
  // List  contactsByMonth(String date){
  //   List filteredcontacts = contacts.where((element) => element.visitDate.month.toString()
  //
  //       ==  date
  //
  //
  //
  //
  //
  //   ).toList();
  //   return filteredcontacts;
  //
  // }
  Contact  contactsbyId(String id){
    Contact filetrdcontacts = contacts.firstWhere((element) => element.ContactId == id);
    return filetrdcontacts;

  }


  // Future <void>  contactUpdate(String id, Contact updatedcontact,var type,String report,[File uploadedImage]) async {
  //
  //
  //   final filetrdcontacts = contacts.indexWhere((element) => element.ContactId == id);
  //
  //   if (filetrdcontacts >= 0) {
  //     if (type == 'checkIn') {
  //       List<int> imageBytes = uploadedImage.readAsBytesSync();
  //       String baseimage = base64Encode(imageBytes);
  //       final url =
  //       Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");
  //
  //       final response = await http.post(url,
  //           body: json.encode({'type': 'checkIn',
  //             'contactId': id,
  //             'checkInLat': updatedcontact.Lat,
  //             'checkInLong': updatedcontact.Long,
  //             'image' : baseimage
  //           }));
  //
  //       print('hello');
  //       print(response.body);
  //
  //
  //       _contacts[filetrdcontacts] = updatedcontact;
  //
  //       await getcontacts();
  //
  //       notifyListeners();
  //     } else if (type == 'checkOut') {
  //       final url =
  //       Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");
  //
  //       final response = await http.post(url,
  //           body: json.encode({'type': 'checkOut',
  //             'contactId': id,
  //             'checkOutLat': updatedcontact.Lat,
  //             'checkOutLong': updatedcontact.Long}));
  //
  //
  //       _contacts[filetrdcontacts] = updatedcontact;
  //       await getcontacts();
  //
  //
  //       notifyListeners();
  //     }
  //     else {
  //       print(report);
  //       final url =
  //       Uri.parse("https://onsitetracking.trottedmedia.com/api/update.php");
  //       print(updatedcontact.report);
  //       final response = await http.post(url,
  //           body: json.encode({
  //             'type': 'report',
  //             'contactId': id,
  //             'report': report,
  //           }));
  //
  //
  //       _contacts[filetrdcontacts] = updatedcontact;
  //
  //       await getcontacts();
  //
  //       notifyListeners();
  //     }
  //   }
  // }

}
