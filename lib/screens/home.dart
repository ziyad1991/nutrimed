import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './contacts.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'profile.dart';
import 'tasks.dart';
import 'archive.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/tasks';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  bool _isinit = true;
  bool _isloading = false;

  DateTime now = DateTime.now();
 List<Widget> appPages = [
   TasksScreen(),
   ContactsScreen(),
   ArchiveScreen()

 ] ;
  void getCurrentPageIndex(int index){
    setState(() {
      _pageIndex = index;

    });

  }

  @override
  Widget build(BuildContext context) {
    final AuthData = Provider.of<AuthProvider>(context);


    return Scaffold(
      bottomNavigationBar: _isloading
          ? null
          : BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: 'Home',
                ),  BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contacts,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fingerprint,
                      color: Theme.of(context).primaryColor),
                  label: 'Archive',
                ),
              


              ],
        onTap: getCurrentPageIndex,
        currentIndex: _pageIndex,
            ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://preview.keenthemes.com/metronic-v4/theme_rtl/assets/pages/media/profile/profile_user.jpg'),
                        maxRadius: 32,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Hello ' + AuthData.getusername,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20)),
                        Text('How Are you today ?',
                            style: TextStyle(color: Colors.black)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),


              Expanded(child:
                 appPages.elementAt(_pageIndex) )
            ]),
    );
  }
}

