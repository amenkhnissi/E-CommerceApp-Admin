import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/models/products.dart';

class ProductsServices {

      Firestore _fireStore = Firestore.instance;

// Add Product category
  void createCategory(String name, String image) {

    _fireStore.collection('product_category').add({
      "category name": name,
      "category image": image,
    });
  }

// Add Product
  void createProduct(Product product) {

    _fireStore.collection('products').add({
      "Product image":product.image,
      "product name": product.name,
      "Product detail": product.detail,
      "Product size": product.size,
      "Product Quantity": product.quantity,
      "Product Color": product.color,
      "Product price": product.price,
    });
  }
  // Add carousol 
  void addCarousel(String title,String description,String image){
    _fireStore.collection('carousel').add({
      'Title' : title,
      'Description' : description,
      'Image' : image,
    });
   

  }
// collection reference
  final CollectionReference productCollection =
      Firestore.instance.collection('products');

  // Products Stream
  Stream<QuerySnapshot> get products {
    return productCollection.snapshots();
  }
// collection reference
  final CollectionReference categoryCollection =
      Firestore.instance.collection('product_category');

  // Products Stream
  Stream<QuerySnapshot> get categories {
    return categoryCollection.snapshots();
  }
}
