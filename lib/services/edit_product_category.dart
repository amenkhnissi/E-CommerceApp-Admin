import 'package:admin_panel/database/products.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';



class EditProductCategory extends StatefulWidget {
  @override
  _EditProductCategoryState createState() => _EditProductCategoryState();
}

class _EditProductCategoryState extends State<EditProductCategory> {

  final GlobalKey<FormState> _productKey = GlobalKey<FormState>();
  
  ProductsServices _product = ProductsServices();
  String category;
  File _image;
  var _imagelink;

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
      String carousel = "category";
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(carousel).child(fileName);
      StorageUploadTask uploadTask =
          firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      final imageUrl = await firebaseStorageRef.getDownloadURL();
      setState(() {
        _imagelink = imageUrl;
        
      });
       _product.createCategory(category,_imagelink);
       Fluttertoast.showToast(msg: 'Successfully uploaded ');
      
      Navigator.pop(context);
    }

    return 
       Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
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
                    label: Text('Add category')),
              ),
                trailing: FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                    label: Text('')),
              ),
              Padding(
                padding: const EdgeInsets.only(left:60.0),
                child: Form(
                  key: _productKey,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Category title",
                          icon: Icon(Icons.category),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (val) {
                          setState(() => category = val);
                        }),
                  ),
                ),
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image,height: 150.0,),
              ),
              
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      );
   
  }
}
