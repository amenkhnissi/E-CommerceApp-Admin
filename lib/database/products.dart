import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsServices {


void createCategory(String name,String image){
   
   Firestore _fireStore = Firestore.instance;

   _fireStore.collection('product_category').add({
     "category name": name,
     "category image": image,
   });



}






}