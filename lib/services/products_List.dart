import 'package:admin_panel/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
 final ProductsServices _productsServices = ProductsServices();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsServices.products,
      builder: (context, snapshot) {
        if (snapshot.hasData);
        var data = snapshot.data;
        return Scaffold(
          appBar:  AppBar(
      backgroundColor: Colors.transparent,
      title: Text('Products List',style: TextStyle(color:Colors.black),),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.list,color:Colors.black),
        )
      ],
      ),
                  body: GridView.builder(
            itemCount: data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) , 
            itemBuilder: (BuildContext context, int index){
              return Product(
                prod_name: data.documents[index]['product name'],
                prod_picture: data.documents[index]['Product image'],
                prod_description: '',
                prod_detail: data.documents[index]['Product detail'],
                prod_old_price: '',
                prod_price: data.documents[index]['Product price'],
                
              );

            }),
        );
      }
    );
  }
}


class Product extends StatelessWidget {

  final prod_name;
  final prod_picture;
  final prod_description;
  final prod_detail;
  final prod_old_price;
  final prod_price;
 

  Product({
    this.prod_name,
    this.prod_picture,
    this.prod_description,
    this.prod_detail,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.white60,
          leading: Text(prod_name),
          title:  Text('£ ' +prod_old_price.toString(),style: TextStyle(color:Colors.red),),
          subtitle: Text('£ ' +prod_price.toString(),style: TextStyle(color:Colors.black)),
          

        ),
        child:  
        Image.network(prod_picture, fit: BoxFit.cover,),
        )
              
    );
    
    
    
    
  }
}