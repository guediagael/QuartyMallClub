import 'package:flutter/material.dart';

class Utils{

  static Color getPrimaryColor()=> Color(0xffF93C64);
  static Color getMainBackgroundColor()=> Color(0xFFF2F4F7);
  static Color getMainTextColor()=> Color(0xFF2D4057);
  static Map<int, Color>primarySwatchColor = {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };

  static BoxDecoration getRedRoundedCornerBoxDecoration(){
    return BoxDecoration(
        color: getPrimaryColor(),
        borderRadius: BorderRadius.all(Radius.circular(41.0))
    );
  }

  static BoxDecoration getWhiteRoundedColoredCornerBoxDecoration(){
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: getPrimaryColor()),
        borderRadius: BorderRadius.all(Radius.circular(41.0))
    );
  }

  static FlatButton getPurpleFlatButton(String text, Function listener, double width, double height){
    return FlatButton(
      onPressed: listener,
      child: Container(
          height: height,
          width: width,
          child: Center(child: Text(text.toUpperCase(), style: TextStyle(fontFamily: 'Montserrat'),))),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: getPrimaryColor()),
          borderRadius: BorderRadius.circular(24)),
      textColor: Colors.white,
      color: getPrimaryColor(),
    );
  }

  static FlatButton getWhiteFlatButton(String text, Function listener){
    return FlatButton(
      onPressed:listener,
      child: Container(height: 50, child: Center(child: Text(text.toUpperCase(), style: TextStyle(fontFamily: 'Montserrat'),))),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: getPrimaryColor()),
          borderRadius: BorderRadius.circular(24)),
      textColor: getPrimaryColor(),
      color: Colors.white,
    );
  }
}