import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatNavigator extends StatefulWidget {
  @override
  _FloatNavigatorState createState() => _FloatNavigatorState();
}

class _FloatNavigatorState extends State<FloatNavigator>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 0; //激活项
  double _height = 48.0; //导航栏高度
  double _floatRadius; //悬浮图标半径
  double _moveTween; //移动补间
  double _padding = 10.0; //浮动图标与圆弧之间的间隙
  AnimationController _animationController; //动画控制器
  Animation<double> _moveAnimation; //移动动画
  List _navs = [
    Icons.search,
    Icons.ondemand_video,
    Icons.music_video,
    Icons.insert_comment,
    Icons.person
  ]; //导航项

  @override
  void initState() {
    _floatRadius = _height * 2 / 3;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _moveAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double singleWidth = width / _navs.length;
    return Container(
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Float Navigator'),
            centerTitle: true,
          ),
          backgroundColor: Color(0xFFFF0035),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: width,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                //浮动图标
                Positioned(
                  top: _animationController.value <= 0.5
                      ? (_animationController.value * _height * _padding / 2) -
                          _floatRadius / 3 * 2
                      : (1 - _animationController.value) *
                              _height *
                              _padding /
                              2 -
                          _floatRadius / 3 * 2,
                  left: _moveAnimation.value * singleWidth +
                      (singleWidth - _floatRadius) / 2 -
                      _padding / 2,
                  child: DecoratedBox(
                    decoration:
                        ShapeDecoration(shape: CircleBorder(), shadows: [
                      BoxShadow(
                          blurRadius: _padding / 2,
                          offset: Offset(0, _padding / 2),
                          spreadRadius: 0,
                          color: Colors.black26),
                    ]),
                    child: CircleAvatar(
                        radius: _floatRadius - _padding, //浮动图标和圆弧之间设置8pixel间隙
                        backgroundColor: Colors.white,
                        child: Icon(_navs[_activeIndex], color: Colors.black)),
                  ),
                ),
                //所有图标
                CustomPaint(
                  child: SizedBox(
                    height: _height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _navs
                          .asMap()
                          .map((i, v) => MapEntry(
                              i,
                              GestureDetector(
                                child: Icon(v,
                                    color: _activeIndex == i
                                        ? Colors.transparent
                                        : Colors.grey),
                                onTap: () {
                                  _switchNav(i);
                                },
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                  painter: ArcPainter(
                      navCount: _navs.length,
                      moveTween: _moveTween ?? 0.0,
                      padding: _padding),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  //切换导航
  _switchNav(int newIndex) {
    double oldPosition = _activeIndex.toDouble();
    double newPosition = newIndex.toDouble();
    if (oldPosition != newPosition &&
        _animationController.status != AnimationStatus.forward) {
      _animationController.reset();
      _moveAnimation = Tween(begin: oldPosition, end: newPosition).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic))
        ..addListener(() {
          setState(() {
            _moveTween = _moveAnimation.value;
          });
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _activeIndex = newIndex;
            });
          }
        });
      _animationController.forward();
    }
  }
}

//绘制圆弧
class ArcPainter extends CustomPainter {
  final int navCount; //导航总数
  final double moveTween; //移动补间
  final double padding; //间隙
  ArcPainter({this.navCount, this.moveTween, this.padding});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = (Colors.white)
      ..style = PaintingStyle.stroke; //画笔
    double width = size.width; //导航栏总宽度，即canvas宽度
    double singleWidth = width / navCount; //单个导航项宽度
    double height = size.height; //导航栏高度，即canvas高度
    double arcRadius = height * 2 / 3; //圆弧半径
    double restSpace = (singleWidth - arcRadius * 2) / 2; //单个导航项减去圆弧直径后单边剩余宽度

    Path path = Path() //路径
      ..relativeLineTo(moveTween * singleWidth, 0)
      ..relativeCubicTo(restSpace + padding, 0, restSpace + padding / 2,
          arcRadius, singleWidth / 2, arcRadius) //圆弧左半边
      ..relativeCubicTo(arcRadius, 0, arcRadius - padding, -arcRadius,
          restSpace + arcRadius, -arcRadius) //圆弧右半边
      ..relativeLineTo(width - (moveTween + 1) * singleWidth, 0)
      ..relativeLineTo(0, height)
      ..relativeLineTo(-width, 0)
      ..relativeLineTo(0, -height)
      ..close();
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
