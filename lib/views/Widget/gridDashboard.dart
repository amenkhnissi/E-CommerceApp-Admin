import 'package:admin_panel/database/database.dart';
import 'package:admin_panel/views/Widget/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_panel/database/authentication.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


final AuthService _auth = AuthService();
final ProductsServices _products = ProductsServices();






class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {

  

  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  
  const StaggeredTile.count(2, 4),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(4, 4),
  
];

List<Widget> _tiles =  <Widget>[

   Tile('N° Users', 'assets/businessman.png', _auth.users),
   Tile('N° Products', 'assets/bar-code.png', _products.products),
   Tile('N° Categories', 'assets/category.png', _products.categories),
   PieChartSample1(),
  

  
 
];

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles  ,
              
              scrollDirection: Axis.vertical,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            ));
  }
}





class Tile extends StatelessWidget {
  const Tile(this.title, this.icon,this.stream);

  final String icon;
  final String title;
  final Stream<QuerySnapshot> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.hasData);
      var data = snapshot.data;

      return Container(
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              '$icon',
              width: 42,
              color: Colors.black,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              '$title',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              height: 8,
            ),
            data == null ?  Text('') :Text(
              '${data.documents.length}',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 14,
            ),
          ],
        ),
      );
    },
  );
  }
}



