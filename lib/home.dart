import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Color _bgColor = Color.fromRGBO(250, 250, 250, 1);
  Color _mainColor = Colors.deepOrangeAccent;
  Color _subColor = Color(0xff30033d);
  List<String> _fonts = ['Playfair', 'RobotoSlab', 'VarelaRound'];
  Size ds = Size(0.0, 0.0);
  String item = '0';

  List<String> items = List.generate(12, (i) => '${i + 1}');
  List<bool> _isPressed = List.filled(12, false);

  Animation _animation(Offset offset) {
    return Tween(begin: offset, end: Offset(0.0, 0.0)).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  AnimationController _animationController;

  TextStyle _style(color, double size, font, {isBold = false}) {
    return TextStyle(
      color: color,
      fontFamily: font,
      fontSize: size,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }

  // ------------------ USING -------------------

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.menu, color: _mainColor),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          child: Icon(Icons.person, color: _mainColor),
        ),
      ],
    );
  }

  Widget _search() {
    return SlideTransition(
      position: _animation(Offset(-1.0, 0.0)),
      child: Container(
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.grey),
            hintText: 'Search',
            hintStyle: _style(Colors.grey, 14.0, _fonts[2], isBold: true),
          ),
        ),
      ),
    );
  }

  Widget _bigContainer(String img) {
    return SlideTransition(
      position: _animation(Offset(-1.5, 0.0)),
      child: Container(
        margin: EdgeInsets.only(right: 20, bottom: 20),
        width: ds.width - 30,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.asset(img, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  Widget _smallIcon(Offset offset, String img, name) {
    return SlideTransition(
      position: _animation(offset),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: Colors.grey, width: 1),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Image.asset(img, fit: BoxFit.fill),
              ),
            ),
            Text(name, style: _style(_subColor, 14, _fonts[0], isBold: true)),
          ],
        ),
      ),
    );
  }

  Widget _card(
      String img, String name, double price, Offset offset, int index) {
    return Builder(
      builder: (context) => FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          setState(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(name + ' ordered'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {},
                ),
              ),
            );
          });
        },
        child: SlideTransition(
          position: _animation(offset),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(8),
            height: 80,
            width: ds.width - 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 1), blurRadius: 1),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 66,
                  width: 66,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(img, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(name,
                                style: _style(_subColor, 18, _fonts[0],
                                    isBold: true)),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPressed[index] = !_isPressed[index];
                                  });
                                },
                                child: Icon(Icons.favorite,
                                    color: _isPressed[index]
                                        ? Colors.redAccent
                                        : Colors.grey[200]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Bakery',
                                style: _style(Colors.grey[500], 14, _fonts[0])),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'Rs. ' + price.toString(),
                                style: _style(
                                    Colors.deepOrangeAccent, 18, _fonts[0],
                                    isBold: true),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    ds = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: <Widget>[
              _header(),
              SizedBox(height: 10),
              _search(),
              SizedBox(height: 20),
              Container(
                height: 140,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _bigContainer('images/img2.jpg'),
                    _bigContainer('images/img1.jpg'),
                    _bigContainer('images/img3.jpg'),
                    _bigContainer('images/img4.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _smallIcon(Offset(-26.0, 0.0), 'images/icon1.jpeg', 'Donuts'),
                  _smallIcon(Offset(-22.0, 0.0), 'images/icon2.jpeg', 'Cakes'),
                  _smallIcon(Offset(-18.0, 0.0), 'images/icon1.jpeg', 'Coffee'),
                  _smallIcon(Offset(-14.0, 0.0), 'images/icon2.jpeg', 'Tea'),
                  _smallIcon(Offset(-10.0, 0.0), 'images/icon1.jpeg', 'Others'),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    _card('images/1.jpg', 'Dark Coffee', 280, Offset(0.0, 10.0),
                        0),
                    _card('images/2.jpg', 'Velvate Cake', 320,
                        Offset(0.0, 14.0), 1),
                    _card(
                        'images/3.jpg', 'Pan Cake', 240, Offset(0.0, 18.0), 2),
                    _card('images/4.jpg', 'Donut', 180, Offset(0.0, 22.0), 3),
                    _card('images/1.jpg', 'Dark Coffee', 280, Offset(0.0, 26.0),
                        4),
                    _card('images/2.jpg', 'Velvate Cake', 320,
                        Offset(0.0, 30.0), 5),
                    _card(
                        'images/3.jpg', 'Pan Cake', 240, Offset(0.0, 32.0), 6),
                    _card('images/4.jpg', 'Donut', 180, Offset(0.0, 36.0), 7),
                    _card('images/1.jpg', 'Dark Coffee', 280, Offset(0.0, 40.0),
                        8),
                    _card('images/2.jpg', 'Velvate Cake', 320,
                        Offset(0.0, 44.0), 9),
                    _card(
                        'images/3.jpg', 'Pan Cake', 240, Offset(0.0, 48.0), 10),
                    _card('images/4.jpg', 'Donut', 180, Offset(0.0, 52.0), 11),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrangeAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home',
                style: _style(Colors.deepOrangeAccent, 14, _fonts[2])),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text('Food', style: _style(Colors.grey, 14, _fonts[2])),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Person', style: _style(Colors.grey, 14, _fonts[2])),
          ),
        ],
      ),
    );
  }
}
