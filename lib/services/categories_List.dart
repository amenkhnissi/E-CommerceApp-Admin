import 'package:admin_panel/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final ProductsServices _productsServices = ProductsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Categories List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.list, color: Colors.black),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _productsServices.categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.documents.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.white60,
                            title: Center(
                              child: Text(
                                  data.documents[index]['category name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold)),
                            ),
                            trailing: Icon(Icons.edit,color:Colors.black87),
                          ),
                          child: Image.network(
                            data.documents[index]['category image'],
                            fit: BoxFit.cover,
                          )),
                    );
                  });
            } else {
              return Text('No users yet');
            }
          }),
    );
  }
}
