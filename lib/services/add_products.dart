import 'package:admin_panel/models/products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../database/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => new _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF696D77), Color(0xFF292C36)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: screenAwareSize(20.0, context),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Add  Product",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenAwareSize(18.0, context),
                      fontFamily: "Montserrat-Bold")),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: screenAwareSize(20.0, context),
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[ProductScreenBottomPart()],
              ),
            )));
  }
}

class ProductScreenBottomPart extends StatefulWidget {
  @override
  _ProductScreenBottomPartState createState() =>
      new _ProductScreenBottomPartState();
}

class _ProductScreenBottomPartState extends State<ProductScreenBottomPart> {
  bool isExpanded = false;
  int currentSizeIndex = 0;
  int currentColorIndex = 0;
  int _counter = 0;
  List selectedsize = [];
  List selectedcolor = [];
  List scolors = [];
  var price;
  File _image;
  var _imagelink;
  String productName;

  final GlobalKey<FormState> _productsKey = GlobalKey<FormState>();
  ProductsServices _product = ProductsServices();

  // Image picker
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _increase() {
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
    });
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  List<Widget> colorSelector() {
    List<Widget> colorItemList = new List();

    for (var i = 0; i < colors.length; i++) {
      colorItemList
          .add(colorItem(colors[i], i == currentColorIndex, context, () {
        setState(() {
          currentColorIndex = i;
          changeSelectedColor(colors[i]);
        });
      }));
    }

    return colorItemList;
  }

  // Select Size
  void changeSelectedSize(String size) {
    if (selectedsize.contains(size)) {
      setState(() {
        selectedsize.remove(size);
      });
    } else {
      setState(() {
        selectedsize.add(size);
      });
    }
  }

  // Select Color
  void changeSelectedColor(Color color) {
    if (selectedcolor.contains(color)) {
      setState(() {
        selectedcolor.remove(color);
      });
    } else {
      setState(() {
        selectedcolor.add(color);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future addProduct(BuildContext context) async {
      String products = "Products";
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(products).child(_image.path);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      final imageUrl = await firebaseStorageRef.getDownloadURL();
      setState(() {
        _imagelink = imageUrl;
        for (var i = 0; i < selectedcolor.length; i++) {
          var a = selectedcolor[i].toString();
          scolors.add(a);
          print(a);
        }
      });
        _product.createProduct(Product(image:_imagelink,name: productName,detail: desc,size: selectedsize,
        quantity: _counter,
        color: scolors,
        price: price
           ));
          Fluttertoast.showToast(msg: 'Product succesfully Added',timeInSecForIosWeb: 2);
      Navigator.pop(context);
    }

    return new Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: screenAwareSize(285.0, context),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: _image == null
                          ? Center(child: Text('Select product image'))
                          : Image.file(_image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 100.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              color: Colors.black38, shape: BoxShape.circle),
                          child: FlatButton.icon(
                            onPressed: () {
                              getImage();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 30,
                              ),
                            ),
                            label: Text(""),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: screenAwareSize(18.0, context),
                  bottom: screenAwareSize(15.0, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Rating",
                          style: TextStyle(
                              color: Color(0xFF949598),
                              fontSize: screenAwareSize(10.0, context),
                              fontFamily: "Montserrat-SemiBold")),
                      SizedBox(
                        height: screenAwareSize(8.0, context),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(Icons.star, color: Color(0xFFFFE600)),
                          SizedBox(
                            width: screenAwareSize(5.0, context),
                          ),
                          Text("4.5",
                              style: TextStyle(color: Color(0xFFFFE600))),
                          SizedBox(
                            width: screenAwareSize(5.0, context),
                          ),
                          Text("(378 People)",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Product Form
          Form(
            key: _productsKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: screenAwareSize(18.0, context)),
                  child: Text(
                    "Product Name",
                    style: TextStyle(
                        color: Color(0xFF949598),
                        fontSize: screenAwareSize(10.0, context),
                        fontFamily: "Montserrat-SemiBold"),
                  ),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: AnimatedCrossFade(
                    firstChild: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Product name",
                          icon: Icon(Icons.title),
                          hintStyle: TextStyle(color: Colors.white38),
                        ),
                        validator: (val) {
                          if (val.length > 20 || val.isEmpty)
                            return 'Name error';
                          else
                            return null;
                        },
                        onChanged: (val) {
                          setState(() => productName = val);
                        }),
                    secondChild: Text(
                      desc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenAwareSize(10.0, context),
                          fontFamily: "Montserrat-Medium"),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: kThemeAnimationDuration,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: screenAwareSize(18.0, context)),
                  child: Text(
                    "Product Description",
                    style: TextStyle(
                        color: Color(0xFF949598),
                        fontSize: screenAwareSize(10.0, context),
                        fontFamily: "Montserrat-SemiBold"),
                  ),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: AnimatedCrossFade(
                    firstChild: TextFormField(
                        maxLines: 3,
                        maxLength: 150,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Product description",
                          icon: Icon(Icons.description),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (val) {
                          if (val.length > 150 || val.isEmpty)
                            return 'Desc error';
                          else
                            return null;
                        },
                        onChanged: (val) {
                          setState(() => desc = val);
                        }),
                    secondChild: Text(
                      desc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenAwareSize(10.0, context),
                          fontFamily: "Montserrat-Medium"),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: kThemeAnimationDuration,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: GestureDetector(
                      onTap: _expand,
                      child: Text(
                        isExpanded ? "less" : "more..",
                        style: TextStyle(
                            color: Color(0xFFFB382F),
                            fontWeight: FontWeight.w700),
                      )),
                ),
                SizedBox(
                  height: screenAwareSize(12.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(15.0, context),
                      right: screenAwareSize(75.0, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Size",
                          style: TextStyle(
                              color: Color(0xFF949598),
                              fontSize: screenAwareSize(10.0, context),
                              fontFamily: "Montserrat-SemiBold")),
                      Text("Quantity",
                          style: TextStyle(
                              color: Color(0xFF949598),
                              fontSize: screenAwareSize(10.0, context),
                              fontFamily: "Montserrat-SemiBold"))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(20.0, context),
                      right: screenAwareSize(10.0, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: screenAwareSize(38.0, context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: sizeNumlist.map((item) {
                            var index = sizeNumlist.indexOf(item);
                            return GestureDetector(
                              onTap: () {
                                currentSizeIndex = index;
                                changeSelectedSize(item);
                                print(selectedsize);
                              },
                              child: sizeItem(
                                  item, index == currentSizeIndex, context),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: screenAwareSize(100.0, context),
                          height: screenAwareSize(30.0, context),
                          decoration: BoxDecoration(
                              color: Color(0xFF525663),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: _decrease,
                                  child: Container(
                                    height: double.infinity,
                                    child: Center(
                                      child: Text("-",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontFamily: "Montserrat-Bold")),
                                    ),
                                  ),
                                ),
                              ),
                              divider(),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  height: double.infinity,
                                  child: Center(
                                    child: Text(_counter.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontFamily: "Montserrat-Bold")),
                                  ),
                                ),
                              ),
                              divider(),
                              Flexible(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: _increase,
                                  child: Container(
                                    height: double.infinity,
                                    child: Center(
                                      child: Text("+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontFamily: "Montserrat-Bold")),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                // Colors list
                Padding(
                  padding:
                      EdgeInsets.only(left: screenAwareSize(18.0, context)),
                  child: Text("Select Color",
                      style: TextStyle(
                          color: Color(0xFF949598),
                          fontSize: screenAwareSize(10.0, context),
                          fontFamily: "Montserrat-SemiBold")),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: screenAwareSize(20.0, context)),
                  height: screenAwareSize(34.0, context),
                  child: Row(
                    children: colorSelector(),
                  ),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                // Price
                Padding(
                  padding:
                      EdgeInsets.only(left: screenAwareSize(20.0, context)),
                  child: Text("Price",
                      style: TextStyle(
                          color: Color(0xFF949598),
                          fontFamily: "Montserrat-SemiBold")),
                ),
                Container(
                  width: double.infinity,
                  height: screenAwareSize(80.0, context),
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter product price",
                        icon: Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.isEmpty)
                          return 'Price not valid';
                        else
                          return null;
                      },
                      onChanged: (val) {
                        setState(() => price = val);
                      }),
                ),
              ],
            ),
          ),
          MaterialButton(
            color: Colors.redAccent,
            onPressed: () {
              if (_productsKey.currentState.validate()) {
                addProduct(context);
              }
            },
            child: ListTile(
              leading: Icon(
                Icons.add,
                size: 40.0,
              ),
              title: Center(
                  child: Text(
                'Add Product',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget sizeItem(String size, bool isSelected, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Container(
      width: screenAwareSize(30.0, context),
      height: screenAwareSize(30.0, context),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFC3930) : Color(0xFF525663),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color:
                    isSelected ? Colors.black.withOpacity(.5) : Colors.black12,
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: Center(
        child: Text(size,
            style:
                TextStyle(color: Colors.white, fontFamily: "Montserrat-Bold")),
      ),
    ),
  );
}

Widget colorItem(
    Color color, bool isSelected, BuildContext context, VoidCallback _ontab) {
  return GestureDetector(
    onTap: _ontab,
    child: Padding(
      padding: EdgeInsets.only(left: screenAwareSize(10.0, context)),
      child: Container(
        width: screenAwareSize(30.0, context),
        height: screenAwareSize(30.0, context),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(.8),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0))
                  ]
                : []),
        child: ClipPath(
          clipper: MClipper(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: color,
          ),
        ),
      ),
    ),
  );
}

class MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget divider() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Container(
      width: 0.8,
      color: Colors.black,
    ),
  );
}

// Data

List<String> sizeNumlist = ["XS", "S", "M", "L", "XL", "XXL"];
List<Color> colors = [
  Color(0xFFF9362E),
  Color(0xFF003CFF),
  Color(0xFFFFB73A),
  Color(0xFF3AFFFF),
  Color(0xFF1AD12C),
  Color(0xFFD66400),
];

String desc =
    "Get maximum support, comfort and a refreshed look with these adidas energy cloud shoes for men comes wit a classic style."
    "Boost your running comfort to the next level with this supportive shoe Synthetic upper with FITFRAME midfoot cage for a locked-down fit and feel"
    "Lace-up closure Cushioned footbed CLOUDFOAM midsole provides responsive padding Durable ADIWEAR™ rubber sole.";

// Screen H*W

double baseHeight = 640.0;
double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
