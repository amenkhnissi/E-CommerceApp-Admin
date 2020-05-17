import 'package:admin_panel/database/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddCarousel extends StatefulWidget {
  @override
  _AddCarouselState createState() => _AddCarouselState();
}

class _AddCarouselState extends State<AddCarousel> {
  
  final ProductsServices _databse = ProductsServices();
  File _image;
    String _title;
    String _description;
    var _imagelink;

  @override
  Widget build(BuildContext context) {
    
    // Image picker
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    Future uploadPic(BuildContext context) async {
      if ( _image != null){
      String fileName = basename(_image.path);
      String carousel = "carousel";
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(carousel).child(fileName);
      StorageUploadTask uploadTask =
          firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      final imageUrl = await firebaseStorageRef.getDownloadURL();
      
      setState(() {
        _imagelink = imageUrl;
        
      });
      _databse.addCarousel(_title, _description, _imagelink);
      Fluttertoast.showToast(msg: 'Successfully Added Item');
      Navigator.pop(context);
      
      }else{
        Fluttertoast.showToast(msg: 'Upload  image');
      }
      
    }

    return Container(
      child: Scaffold(
        body: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FlatButton.icon(
                      onPressed: () {
                        uploadPic(context);
                      },
                      icon: Icon(Icons.add_a_photo),
                      label: Text('Add Carousel')),
                ),
                trailing: FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                    label: Text('')),
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image, height: 150.0),
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    maxLength: 30,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "title",
                        icon: Icon(Icons.title),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (val) {
                        setState(() => _title = val);
                      }),
                  TextFormField(
                     maxLines: 4,
                     maxLength: 250,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        icon: Icon(Icons.description),
                        hintStyle: TextStyle(color: Colors.grey),                    
                      ),
                      onChanged: (val) {
                        setState(() => _description = val);
                      }),
                ],
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
