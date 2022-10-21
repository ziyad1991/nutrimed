import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ContactsProvider with ChangeNotifier {
  String userId;

  void updateAuth ( String uid) {

    this.userId = uid;
    notifyListeners();

  }


  List _contacts = [];
  var _contactsType = [];

  ContactsProvider(this.userId,this._contacts);

  List<Contact> get contacts {
    _contacts.sort((a, b){

      return b.Status.compareTo(a.Status);

      //softing on numerical order (Ascending order by Roll No integer)
    });
    return [..._contacts];
  }

  List<String> get ContactType {
     return [..._contactsType];

   }
  List  ContactByStatus(String Status){
    List filetrdContacts = contacts.where((element) => element.Status == Status).toList();
    return filetrdContacts;

  }


  Future<void> getcontacts() async {
    print('getting contacts');


    try {
      var url =
      Uri.parse(
          "https://nutrimed.trottedmedia.com/api/contacts.php?method=select&dataType=contacts&userid=$userId");
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print (json.decode(response.body));
      final List<Contact> loadedData = [];
      extractedData.forEach((contactId, contactData) {


        loadedData.add(Contact(
            ContactId: contactId,

            ContactName: contactData['contact'],
            Type: contactData['locationType'],
            Status: contactData['locationStatus'],
            Address: contactData['contactaddress'],
            Phone: contactData['phone'],
            Lat: contactData['lat'],
            Long: contactData['lng'],
            details: contactData['details'],
        ));
      });

      _contacts = loadedData;
      notifyListeners();

    }catch(e) {

      print(e);

    }


  }
 Future<void> AddContact($Name,$Phone,$Address,$Type,$Lat,$Long) async{
   final url =
   Uri.parse("https://nutrimed.trottedmedia.com/api/adddata.php");

   final response = await http.post(url,
       body: json.encode({'name': $Name,
         'phone': $Phone,
         'address': $Address,
         'type': $Type,
         'lat' : $Lat,
         'long' : $Long,
         'agent' : userId

       }));



 }
  Future<void> getContactsTypes() async {
    print('hello contacts type');


    try {
      var url =
      Uri.parse(
          "https://nutrimed.trottedmedia.com/api/contacts.php?method=select&dataType=contactsType");
      final response = await http.get(url);
      List<dynamic> items = [];
       items = json.decode(response.body) as List<dynamic>;


      _contactsType = items;

      notifyListeners();

      print(_contactsType);

    }catch(e) {

      print(e);

    }


  }


  Contact  ContactbyId(String id){
    Contact FilterdContact = contacts.firstWhere((element) => element.ContactId == id);
    return FilterdContact;

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
  // String getcontacttype(String theid) {
  //
  //   Contact filetrdcontacts = contacts.firstWhere((element) => element.ContactId == theid);
  //
  //   return '1';
  //
  //
  // }
  List  contactsbyType(String type){
    List filetrdcontacts = contacts.where((element) => element.Status == type).toList();
    return filetrdcontacts;

  }


  List  contactsbydate(){
    List filetrdcontacts = contacts.where((element) => element.ContactId != 0
    ).toList();
    return filetrdcontacts;

  }
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
