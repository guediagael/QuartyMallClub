import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quarty_mall_club/screens/main/main.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/commons.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  var _phoneFormKey = GlobalKey<FormState>();
  var _codeFormKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  bool _isPhoneSent, _isFirstTry;
  double _screenWidth, _screenHeight;
  double formFieldPaddingVert;
  double formFieldPaddingHor;

  @override
  void initState() {
    _isPhoneSent = false;
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
          onPressed: () {
            if (_isPhoneSent) {
              setState(() {
                _isPhoneSent = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
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
          _isPhoneSent ? _getCodeForm() : _getPhoneForm(),
          SizedBox(
            height: 16,
          ),
          Utils.getPurpleFlatButton(_isPhoneSent ? GO_TO_LIST : GET_CODE,
              () => _checkForm(), _screenWidth * 2 / 3, _screenHeight / 13)
        ],
      ),
    );
  }

  Form _getPhoneForm() {
    return Form(
      key: _phoneFormKey,
      child: TextFormField(
        autofocus: true,
        controller: _phoneController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: formFieldPaddingHor,
                vertical: formFieldPaddingVert),
            hintText: ADD_PHONE_NUMBER),
        validator: (phone) {
          if (phone.isEmpty) return ERROR_COMPULSORY_FIELD;
          if (phone.trim().length != 16) return TO_LONG;
        },
      ),
      autovalidate: !_isFirstTry,
    );
  }

  Form _getCodeForm() {
    return Form(
      key: _codeFormKey,
      child: TextFormField(
        autofocus: true,
        controller: _codeController,
        validator: (code) {
          if (code.isEmpty) {
            return ERROR_COMPULSORY_FIELD;
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: formFieldPaddingHor,
                vertical: formFieldPaddingVert),
            hintText: INSERT_CODE),
      ),
      autovalidate: !_isFirstTry,
    );
  }

  _sendPhoneNumber() {}

  _sendCode() {}

  _checkForm() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MainScreen()));
//    setState(() {
//      _isPhoneSent = true;
//    });
  }
}
