import 'package:flutter/material.dart';
import 'package:onsite_tracking/screens/home.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  bool loading = false;


  void loginUser(ctx) async{
    setState(() {
      loading = true;
    });

    final Auth = Provider.of<AuthProvider>(context,listen: false);
    final _validator = _formKey.currentState.validate();

      if(_validator){
      _formKey.currentState.save();
      final authresposnebody = await Auth.loginUser(userEmail, userPassword, true);




      if(authresposnebody['responscode'] == 100){

          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('User Not Found')));


      }

      if(authresposnebody['responscode']  == 101){

        ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('Wrong Password')));}

      if(authresposnebody['responscode'] == 102){

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen() ))

        // print(authResponse.toString());
        // Scaffold.of(ctx).showSnackBar(
        // SnackBar(content: Text('yes')))
        //
        ;}

      }
    setState(() {
      loading = false;
    });

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height:MediaQuery.of(context).size.height / 2 ,
              child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,),
            ),

            Container(

              child: Card(


                elevation: 5,
                color: Colors.white,
                margin: EdgeInsets.only(left: 25,right: 25),


                child: Container(


                  margin: EdgeInsets.only(left: 25,right: 25),

                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70)
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'Email Cannot be Empty';
                          }
                        return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email',hintStyle: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor
                        )),
                        onSaved: (email){
                          userEmail = email.toString();
                        },
                      ),
                        TextFormField(
                     validator: (value){
                       if(value.isEmpty){
                      return 'Password Cannot be Empty';
                        }
                       return null;
                       },
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          onSaved: (password){
                            userPassword = password.toString();
                          },
                        ),
                      SizedBox(
                        height: 10,
                      ),
                        loading ? Center(child: CircularProgressIndicator()) : MaterialButton(
                          height: 40.0,
                          minWidth: 100.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: new Text("login"),
                          onPressed: (){loginUser(context);},
                        ),

                      FlatButton(

                          onPressed: (){loginUser(context);}, child: Text('Forgot you password ?'))],

                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
