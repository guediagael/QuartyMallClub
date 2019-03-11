import 'package:flutter/material.dart';
import 'package:quarty_mall_club/Utils.dart';
import 'package:quarty_mall_club/string_resources.dart';

class LoginScreen extends StatelessWidget {
  double _screenWidth, _screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 24)),
          Image(
            image: AssetImage('assets/pictures/two_bags_big.png'),
            fit: BoxFit.cover,
            width: _screenWidth,
            height: _screenHeight * 2 / 5,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 32)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: FlatButton(
              onPressed: _openAddCardScreen,
              child: Container(height: 50, child: Center(child: Text(ADD_CARD))),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Utils.getPrimaryColor()),
                  borderRadius: BorderRadius.circular(24)),
              textColor: Colors.white,
              color: Utils.getPrimaryColor(),
            ),
          ),
          Padding(padding: EdgeInsets.all(8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: FlatButton(
              onPressed: _openOrderNewCardScreen,
              child: Container(height: 50, child: Center(child: Text(ORDER_A_CARD))),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Utils.getPrimaryColor()),
                  borderRadius: BorderRadius.circular(24)),
              textColor: Utils.getPrimaryColor(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _openOrderNewCardScreen() {
    print("ordering a card");
  }

  _openAddCardScreen() {
    print("adding card");
  }
}
