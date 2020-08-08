import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/Models/DetailsModels.dart';
import 'package:wasteagram/Services/Database.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final formKey = GlobalKey<FormState>();
  File _image;
  String number;
  String date;
  String urlImage;
  String location;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void savedetails(urlImage, location) {
    var t = DetailsModel(
      date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
      imageUrl: urlImage,
      number: number,
      location: location,
    );

    Collections().addToPhone(t);
    Navigator.of(context).pushReplacementNamed('home');
  }

  void uploadImage() async {
    final StorageReference phoneImage =
        FirebaseStorage.instance.ref().child('Wastegram');
    var timeKey = DateTime.now();
    final StorageUploadTask uploadTask =
        phoneImage.child(timeKey.toString() + '.jpg').putFile(_image);

    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    urlImage = imageUrl.toString();
    
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    location = position.toString();

    savedetails(urlImage, location);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        elevation: 00,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * .75,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: (_image != null)
                              ? Image.file(_image, fit: BoxFit.fill)
                              : IconButton(
                                  icon: Icon(
                                    Icons.photo_camera,
                                    size: 70,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            hintText: 'Number of Wasted Items',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 23.5),
                          ),
                          validator: (input) =>
                              input == '' ? 'Please enter a number' : null,
                          onSaved: (input) => number = input,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueAccent,
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * 1,
              child: IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.cloud_upload,
                  size: 90,
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    uploadImage();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
