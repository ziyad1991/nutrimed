class Contact {

  String ContactId;
  String ContactName;
  String Phone;
  String Address;
  String Note;
  String Type;
  String Lat;
  String Long;
  String Status;
  String Adder;
  DateTime addDate;
  String details;





  Contact({this.ContactId,
  this.ContactName,
  this.Phone,
  this.Address,
  this.Note,
  this.Type,
  this.Lat,
  this.Long,
  this.Status,
  this.Adder,
    this.details,

    DateTime addDate,
  });


}

class ContactsType {

  String TypeId;
  String TypeName;





  ContactsType({this.TypeId,
    this.TypeName,
  });


}