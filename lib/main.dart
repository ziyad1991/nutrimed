import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart';
import 'provider/visits_provider.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/onboarding.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return AuthProvider();
        }),

        ChangeNotifierProxyProvider<AuthProvider, VisitsProvider>(
          create: (_) => VisitsProvider('', []),
          update: (ctx, auth, previousProductsProvider) =>
          previousProductsProvider
            ..updateAuth(
              auth.userNamec,
            ),
        ),




      ],

        child: Consumer<AuthProvider>(builder: (ctx, auth, _) {

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedLabelStyle: TextStyle(
                  color: Colors.black87
              ),
                unselectedLabelStyle:
                TextStyle(
                    color: Colors.black87
                ),
              ),
              backgroundColor: Colors.black,
                primaryColor: Color.fromRGBO(36, 53,112,1 ),
                buttonColor: Colors.red,
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(36, 53,112,1 )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(36, 53,112,1 )),
                  ),
                ),
                appBarTheme: AppBarTheme(color: Color.fromRGBO(36, 53,112,1 )),
                buttonTheme: ButtonThemeData(buttonColor: Color.fromRGBO(36, 53,112,1 )),
                buttonBarTheme:
                ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.accent,





                ),


              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
            ),
            home: auth.dbusername
                ? HomeScreen()
                : FutureBuilder(
                future: auth.userName,
                builder: (ctx, authstream) =>
                authstream.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : onboarding()),
            routes: {
              onboarding.routeName: (ctx) => onboarding(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              // ListScreen.routeName: (ctx) => ListScreen(_),
            });
      }),
    );

  }
}


