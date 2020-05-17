import 'package:admin_panel/models/admin.dart';
import 'package:admin_panel/services/add_carousel.dart';
import 'package:admin_panel/services/add_categories.dart';
import 'package:admin_panel/services/add_products.dart';
import 'package:admin_panel/views/Widget/gridDashboard.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/database/authentication.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();

  TabController adminTab;

  @override
  void initState() {
    super.initState();
    adminTab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Admin>(context);

    // Add Carousel images

    void _AddCarousel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: AddCarousel(),
            );
          });
    }

    // Add Product Category
    void _AddProductCategory() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: AddProductCategory(),
            );
          });
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pic5.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Dashboard'),
            bottom: TabBar(
                controller: adminTab,
                isScrollable: true,
                indicatorColor: Colors.white,
                tabs: [
                  Icon(Icons.dashboard),
                  Icon(Icons.settings_applications),
                ])),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                accountName: Text('Admin'),
                accountEmail: Text(user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'Users List');
                },
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                title: Text('Users list'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'Categories List');
                },
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                title: Text('Categories list'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'Products List');
                },
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                title: Text('products list'),
              ),
              InkWell(
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: ListTile(
                  leading:
                      Icon(Icons.supervised_user_circle, color: Colors.black),
                  title: Text('Sign Out'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: adminTab,
          children: [
            // Dashboard UI

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridDashboard(),
            ),

            // Admin manage Store
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.transparent,
                  // Admin Settings List
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      // Add carousel Images
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _AddCarousel();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              leading: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                              title: Text('Add Carousel Fashion Images',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      // Add Product category
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _AddProductCategory();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              leading: Icon(
                                Icons.category,
                                color: Colors.black,
                              ),
                              title: Text('Add Product category',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      // Add Product
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddProducts();
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              leading: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.black,
                              ),
                              title: Text('Add Product',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
