import 'package:admin_panel/database/authentication.dart';
import 'package:admin_panel/database/products.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex;
  final AuthService _auth = AuthService();
  final ProductsServices _products = ProductsServices();

  var productsCount;
  var categoriesCount;
  var usersCount;
  @override
  void initState(){
   _products.productCollection.getDocuments().then((val){
     setState(() {
       productsCount = val.documents.length;
     });
    });
   _products.categoryCollection.getDocuments().then((val){
     setState(() {
       categoriesCount = val.documents.length;
     });
    });
    _auth.usersCollection.getDocuments().then((val){
     setState(() {
       usersCount = val.documents.length;
     });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Indicator(
                    color: const Color(0xff0293ee),
                    text: 'Users',
                    isSquare: false,
                    size: touchedIndex == 0 ? 18 : 16,
                    textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  Indicator(
                    color: const Color(0xfff8b250),
                    text: 'Products',
                    isSquare: false,
                    size: touchedIndex == 1 ? 18 : 16,
                    textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  Indicator(
                    color: const Color(0xff845bef),
                    text: 'Categories',
                    isSquare: false,
                    size: touchedIndex == 2 ? 18 : 16,
                    textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                  ),
                 
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 12,
                        centerSpaceRadius: 0,
                        sections: showingSections()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        var total = usersCount+productsCount+categoriesCount;
        var users = usersCount/total*100;
        var products = productsCount/total*100;
        var categories = productsCount/total*100;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value:  usersCount+.0,
              title: '${users.toInt()}'+'%',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: productsCount+.0,
              title: '${products.toInt()}'+'%',
              radius: 65,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef).withOpacity(opacity),
              value: categoriesCount+.0,
              title: '${categories.toInt()}'+'%',
              radius: 60,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          default:
            return null;
        }
      },
    );
  }
}