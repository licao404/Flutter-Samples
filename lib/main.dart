import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Samples',
      color: Colors.blue,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (BuildContext context) {
          return new HomePage();
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> cates = [
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
    {'title': 'WaterFall', 'path': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      backgroundColor: new Color.fromRGBO(244, 245, 245, 1),
      child: new CustomScrollView(
        slivers: <Widget>[
          new CupertinoSliverRefreshControl(),
          new SliverAppBar(
            title: new Text('Samples'),
            centerTitle: true,
            pinned: true,
          ),
          new SliverGrid(
            delegate: new SliverChildListDelegate(
                cates.map((cate) => _buildCard(cate)).toList()),
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 6.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(cate) {
    print(cate);
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, cate['path']);
      },
      child: new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(
              Radius.circular(5.0),
            ),
            border: new Border.all(color: new Color.fromRGBO(235, 235, 235, 1)),
            boxShadow: [
              new BoxShadow(
                  color: new Color.fromRGBO(235, 235, 235, 1),
                  blurRadius: 20.0,
                  offset: new Offset(0.0, 20.0))
            ],
            color: Colors.white,
          ),
          padding: new EdgeInsets.all(20.0),
          child: new Center(
            child: new Text(
              cate['title'],
              style: new TextStyle(fontSize: 24.0),
            ),
          )),
    );
  }
}
