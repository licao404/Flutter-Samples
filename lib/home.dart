import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/floatNavigator.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Effects'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: AssetImage('images/float_navigator.png'),
                            fit: BoxFit.cover)),
                    child: Text('Float Navigator',
                        style: TextStyle(height: 1.5, color: Colors.white)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return FloatNavigator();
                    }));
                  },
                ),
              ],
              childAspectRatio: 0.78,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
          )
        ],
      ),
    );
  }
}
