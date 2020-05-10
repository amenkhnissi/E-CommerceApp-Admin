import 'package:admin_panel/models/admin.dart';
import 'package:admin_panel/services/edit_carousel.dart';
import 'package:admin_panel/services/edit_product_category.dart';
import 'package:admin_panel/views/admin_login.dart';
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

    // Edit Carousel

    void _EditCarousel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: EditCarousel(),
            );
          });
    }

    void _EditProductCategory() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: EditProductCategory(),
            );
          });
    }
    print(user.uid);
    print(user.email);
    return user == null ? Login() : Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(100, 100, 50, 100),
          centerTitle: true,
          title: Text('Dashboard'),
          bottom: TabBar(controller: adminTab, tabs: [
            Icon(Icons.dashboard),
            Icon(Icons.settings_applications),
          ])),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pic5.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          color: Color.fromRGBO(100, 100, 50, 200),
          child: TabBarView(
            controller: adminTab,
            children: [
              // Dashboard UI
              Container(
                  color: Color.fromRGBO(50, 100, 50, 130),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisSpacing: 5.0,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(50, 100, 50, 130)),
                          child: GridTile(
                            header: Icon(Icons.money_off, size: 60),
                            child: Center(child: Text('500 £')),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(50, 100, 50, 130))),
                      ],
                    ),
                  )),
              // Admin manage Store
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.transparent,
                    // Admin Settings List
                    child: ListView(
                      children: <Widget>[
                        // Add carousel Images
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _EditCarousel();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                                title: Text('Add Carousel Fashion Images',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        // Add Product category
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _EditProductCategory();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                                title: Text('Add Poduct category',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              await _auth.signOut();
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.black,
                                ),
                                title: Text('Sign Out',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
