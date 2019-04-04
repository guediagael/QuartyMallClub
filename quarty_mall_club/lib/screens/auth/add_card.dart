import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quarty_mall_club/api/auth_api.dart';
import 'package:quarty_mall_club/screens/main/main.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  var _cardFormKey = GlobalKey<FormState>();
  TextEditingController _cardController = TextEditingController();
  bool _isFirstTry;
  double _screenWidth, _screenHeight;
  double formFieldPaddingVert;
  double formFieldPaddingHor;

  @override
  void initState() {
    _isFirstTry = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    formFieldPaddingVert = (_screenHeight * .0195).toDouble();
    formFieldPaddingHor = (_screenWidth * .0667).toDouble();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>Navigator.pop(context),
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          LETS_ADD_A_CARD,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        children: <Widget>[
          Center(
            child: Container(
              width: _screenWidth * 2 / 7,
              height: _screenHeight * 1 / 5,
              child: Image(
                image: AssetImage(
                  'assets/pictures/one_bag_big.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          _getForm(),
          SizedBox(
            height: 16,
          ),
          Utils.getPurpleFlatButton(SEND,
              () => _checkForm(), _screenWidth * 2 / 3, _screenHeight / 13)
        ],
      ),
    );
  }

  Form _getForm() {
    return Form(
      key: _cardFormKey,
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.number,
        controller: _cardController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: formFieldPaddingHor,
                vertical: formFieldPaddingVert),
            hintText: ADD_CARD_NUMBER),
        validator: (cardNumber) {
          if (cardNumber.isEmpty) return ERROR_COMPULSORY_FIELD;
          if (cardNumber.trim().length >= 16) return TO_LONG;
        },
      ),
      autovalidate: !_isFirstTry,
    );
  }

//  Form _getCodeForm() {
//    return Form(
//      key: _codeFormKey,
//      child: TextFormField(
//        autofocus: true,
//        controller: _codeController,
//        validator: (code) {
//          if (code.isEmpty) {
//            return ERROR_COMPULSORY_FIELD;
//          }
//        },
//        decoration: InputDecoration(
//            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
//            contentPadding: EdgeInsets.symmetric(
//                horizontal: formFieldPaddingHor,
//                vertical: formFieldPaddingVert),
//            hintText: INSERT_CODE),
//      ),
//      autovalidate: !_isFirstTry,
//    );
//  }

  _sendPhoneNumber() {}

  _sendCode() {}

  _checkForm() {
    if(_cardFormKey.currentState.validate()){
      int cardNumber = int.parse(_cardController.text.trim());
      AuthApi.internal().getToken(cardNumber).then((response) {
        var token = response["token"];
        print("token: $token");
        SharedPreferences.getInstance().then((sp) {
          sp.setString(SP_KEY_TOKEN, token).then((isSet) {
            if (isSet) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => MainScreen()));
            }
          });
        });
      });
    }

  }
}
