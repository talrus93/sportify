import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String image1 =
      'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1866&q=80';
  String image2 =
      'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1860&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TiltWidget(
                yaxis: (MediaQuery.of(context).size.width / 2) / 2,
                image: image1,
                text: 'Cliffs of Cinque',
                subText: 'Manarola, Italy'),
            TiltWidget(
              yaxis: (MediaQuery.of(context).size.width / 2) +
                  (MediaQuery.of(context).size.width / 2) / 2,
              image: image2,
              text: 'Rialto Bridge',
              subText: 'Venezia, Italy',
            ),
          ],
        ),
      ),
    );
  }
}

class TiltWidget extends StatefulWidget {
  final double yaxis;
  final String image;
  final String text;
  final String subText;

  TiltWidget({required this.yaxis,required this.image,required this.text,required this.subText});

  @override
  _TiltWidgetState createState() => _TiltWidgetState();
}

class _TiltWidgetState extends State<TiltWidget> {
  double x = 0.0;
  double y = 0.0;
  double borderValueY = 150.0;
  double borderValueX = 200.0;
  double beginY = 0.0;
  double endY = 0.0;
  double beginX = 0.0;
  double endX = 0.0;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      tween: Tween(
        begin: beginX,
        end: endX,
      ),
      builder: (context, valueX, child) => TweenAnimationBuilder(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 300),
        tween: Tween(
          begin: beginY,
          end: endY,
        ),
        builder: (context, valueY, child) {
          return Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(valueX)
                  ..rotateY(valueY),
                alignment: FractionalOffset.center,
                child: MouseRegion(
                  onHover: (details) {
                    double yvalue = widget.yaxis - details.localPosition.dx;
                    double xvalue = (MediaQuery.of(context).size.height / 2) -
                        details.localPosition.dy;
                    print(xvalue);
                    if (yvalue <= borderValueY && yvalue >= -borderValueY) {
                      setState(() {
                        double oldRange = (borderValueY - (-borderValueY));
                        double newRange = (0.35 - (-0.35));
                        double newValue =
                            (((yvalue - (-borderValueY)) * newRange) /
                                    oldRange) +
                                (-0.35);
                        beginY = y;
                        y = newValue;
                        endY = y;
                        oldRange = (borderValueX - (-borderValueX));
                        newRange = (0.35 - (-0.35));
                        newValue = (((-xvalue - (-borderValueX)) * newRange) /
                                oldRange) +
                            (-0.35);
                        beginX = x;
                        x = newValue;
                        endX = x;
                      });
                    }
                  },
                  onExit: (event) {
                    print('exited');
                    setState(() {
                      y = 0.0;
                      x = 0.0;
                      beginY = 0.0;
                      endY = 0.0;
                      beginX = 0.0;
                      endX = 0.0;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 300.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20.0,
                        right: 20.0,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(0.0, 0.0, -20.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        left: 20.0,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(0.0, 0.0, -30.0),
                          alignment: FractionalOffset.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.text,
                                style: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: textColor,
                                    size: 13.0,
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    widget.subText,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w300,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  //SizedBox(width: 3.0,),
                                  Icon(
                                    Icons.star,
                                    color: textColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: textColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: textColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.star_half,
                                    color: textColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.star_border,
                                    color: textColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '3.5',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
