import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/db_helper.dart';


class AuthProvider with ChangeNotifier {
  String _username;
  String _userId;
  String _userRole;

  String _dbuserid;
  String _dbusername;
  String _dbUserRole;

  bool get dbusername {
    return _dbusername != null;
  }
  String get userNamec {
    return _dbuserid;
  }

  String get getusername {
    String fullName = _dbusername;
    String firstSen = fullName.split(" ").elementAt(0);
    var userName =toBeginningOfSentenceCase(firstSen);

    return userName;
  }

  // String email;
  //   // String password;
  final _userinfo = {'userName': '', 'password': '', 'name': '','id' : '','role':''};


  Map<String, dynamic> get userinfo {
    return _userinfo;
  }

  Future<Map<String, dynamic>> loginUser(
      String email, String password, bool isLogin) async {
    final url =
    Uri.parse('https://nutrimed.trottedmedia.com/api/api.php');
    final response = await http.post(url,
        body: json.encode({'username': email, 'password': password}));

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    _username = responseBody['name'];
    _userId = responseBody['id'];
    _userRole = responseBody['role'];

    await sqlDatabase.insertdata('users', {'email': email, 'name': _username,'idofuser' :_userId ,'roleOfUser' :_userRole});
    _dbusername = _username;
    _dbuserid = _userId;
    _dbUserRole = _userRole;

    notifyListeners();

    // var respondMap = json.decode(responseBody) as Map<String,dynamic>;

    return responseBody;
  }

  Future<String> get userName async {
    var data = await sqlDatabase.getUsername();
    var dataid = await sqlDatabase.getUserId();
    var dataRole = await sqlDatabase.getUserRole();

    userinfo['userName'] = data;
    userinfo['idofuser'] = dataid;
    // userinfo['idofuser'] = dataRole;

    _dbuserid = userinfo['idofuser'];
    _dbusername = userinfo['userName'];

    notifyListeners();
  }
}