import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pick_city.dart';

// Do not forget to create location icon in image for main page
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(68, 53, 82, 1),
          fontFamily: 'Nunito'),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Select sport:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Football',
                        imagePath: 'assets/images/f1.jpg',
                        background: Colors.deepPurple),
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) +
                            (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Tennis',
                        imagePath: 'assets/images/t6.png',
                        background: Colors.deepPurple),
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Basketball',
                        imagePath: 'assets/images/b4.jpg',
                        background: Colors.deepPurple),
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) +
                            (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Running',
                        imagePath: 'assets/images/tr.jpg',
                        background: Colors.deepPurple),
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) +
                            (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Football',
                        imagePath: 'assets/images/f12.jpg',
                        background: Colors.deepPurple),
                    ItemSport(
                        yaxis: (MediaQuery.of(context).size.width / 2) +
                            (MediaQuery.of(context).size.width / 2) / 2,
                        title: 'Tennis',
                        imagePath: 'assets/images/t9.jpg',
                        background: Colors.deepPurple),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemSport extends StatefulWidget {
  final double yaxis;
  final String title;
  final String imagePath;
  final Color background;
  const ItemSport(
      {Key? key,
      required this.yaxis,
      required this.title,
      required this.imagePath,
      required this.background})
      : super(key: key);

  @override
  _ItemSportState createState() => _ItemSportState();
}

class _ItemSportState extends State<ItemSport> {
  double x = 0.0;
  double y = 0.0;
  double borderValueY = 150.0;
  double borderValueX = 200.0;
  double beginY = 0.0;
  double endY = 0.0;
  double beginX = 0.0;
  double endX = 0.0;

  bool isFavorite = false;
  Color titleColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.width / 2;
    return TweenAnimationBuilder(
      tween: Tween(begin: beginX, end: endX),
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 375),
      builder: (context, valueX, child) => TweenAnimationBuilder(
        tween: Tween(begin: beginY, end: endY),
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 375),
        builder: (context, valueY, child) {
          return Transform(
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

                if (yvalue <= borderValueY && yvalue >= borderValueY) {
                  setState(() {
                    double oldRange = (borderValueY - (-borderValueY));
                    double newRange = (0.35 - (-0.35));
                    double newValue =
                        (((yvalue - (-borderValueY)) * newRange) / oldRange) +
                            (-0.35);
                    beginY = y;
                    y = newValue;
                    endY = y;

                    oldRange = (borderValueX - (-borderValueX));
                    newRange = (0.35 - (-0.35));
                    newValue =
                        (((-xvalue - (-borderValueX)) * newRange) / oldRange) +
                            (-0.35);
                    beginX = x;
                    x = newValue;
                    endX = x;
                  });
                }
              },
              onExit: (event) {
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
                  GestureDetector(
                    onTap: () {
                      // Navigate to the "pick_city" page here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PickCityPage()), // Replace with actual page
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 156, 133,
                                173), // Start color of the gradient
                            Color.fromARGB(
                                255, 107, 36, 136), // End color of the gradient
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            spreadRadius: 0,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      height: containerHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: containerHeight * 0.05,
                    right: containerHeight * 0.05,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0, 0.0, -30.0),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red[800] : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 50,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0, 0.0, -30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}