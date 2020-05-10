import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class EditCarousel extends StatefulWidget {
  @override
  _EditCarouselState createState() => _EditCarouselState();
}

class _EditCarouselState extends State<EditCarousel> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      String carousel = "carousel";
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref();
      StorageUploadTask uploadTask =
          firebaseStorageRef.child(carousel).child(fileName).putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      
      Navigator.pop(context);
    }

    return Container(
      child: Scaffold(
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              ListTile(
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
                    : Image.file(_image),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FlatButton.icon(
                    onPressed: () {
                      uploadPic(context);
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text('Upload photo')),
              )
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
