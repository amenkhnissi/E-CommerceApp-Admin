import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductsServices {

// Add Product category
void createCategory(String name,String image){
   
   Firestore _fireStore = Firestore.instance;

   _fireStore.collection('product_category').add({
     "category name": name,
     "category image": image,
   });



}
// Add Product

void createProduct(String image,String name,String detail,List size,int quantity,List color,String price){
   
   Firestore _fireStore = Firestore.instance;

   _fireStore.collection('products').add({
     "Product image": image,
     "product name":name,
     "Product detail": detail,
     "Product size" : size,
     "Product Quantity" : quantity,
     "Product Color" : color,
     "Product price" : price,
   });



}






}