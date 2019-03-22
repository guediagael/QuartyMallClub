import 'package:flutter/material.dart';
import 'package:quarty_mall_club/screens/auth/add_card.dart';
import 'package:quarty_mall_club/screens/auth/order_new_card.dart';
import 'package:quarty_mall_club/utils/commons.dart';
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
            child: Utils.getPurpleFlatButton(ADD_CARD, ()=>_openAddCardScreen(context), null, 50)

          ),
          Padding(padding: EdgeInsets.all(8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Utils.getWhiteFlatButton(ORDER_A_CARD, ()=>_openOrderNewCardScreen(context))
          ),
        ],
      ),
    );
  }

  _openOrderNewCardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> NewCardScreen()));
  }

  _openAddCardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddCardScreen()));
  }
}
