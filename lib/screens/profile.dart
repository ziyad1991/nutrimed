import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  File uploadedImage;


  void changeImage() async{
    setState(() {
      isLoading = true;

    });

    final ImagePickerx = ImagePicker();
    var imageFile = await ImagePickerx.getImage(source: ImageSource.camera, maxWidth: 300, imageQuality: 100,
    );


    if (imageFile != null) {
      setState(() {
        uploadedImage = File(imageFile.path);
      });
    }}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child:
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: ListView(

                          children: [


                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: (){
                                  changeImage();
                                },
                                child: CircleAvatar(
                                  backgroundImage: uploadedImage == null ? NetworkImage('https://preview.keenthemes.com/metronic-v4/theme_rtl/assets/pages/media/profile/profile_user.jpg') : FileImage(File(uploadedImage.path)),
                                  maxRadius: 90, ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(

                                  keyboardType: TextInputType.emailAddress,
                                initialValue: 'Ziyado1991@gmail.com' ,// Use email input type for emails.
                                  decoration: new InputDecoration(
                                      hintText: 'Ziyado1991@gmail.com',
                                      labelText: 'E-mail Address'

                                  ),


                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  initialValue: 'Ziyad Shoeky' ,// Use email input type for emails.

                                  decoration: InputDecoration(
                                    hintText: 'Ziyad Shoeky',
                                    labelText: 'Full Name'
                                  ),


                                ),
                              ),

Padding(
  padding: const EdgeInsets.all(20.0),
  child:   TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),

        onPressed: (){
    print('asdasd');
  }, child: Text('Save',style: TextStyle(
    fontSize: 20,
    color: Colors.white
  ),)),
)
                              ],




              ),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
