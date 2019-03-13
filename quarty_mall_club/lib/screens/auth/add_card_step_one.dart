import 'package:flutter/material.dart';
import 'package:quarty_mall_club/Utils.dart';
import 'package:quarty_mall_club/string_resources.dart';

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
            if(_isPhoneSent){
              setState(() {
                _isPhoneSent = false;
              });
            }else{
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
              width: _screenWidth * 2/7,
              height: _screenHeight * 1/5,
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
          _isPhoneSent? _getCodeForm() : _getPhoneForm(),
          SizedBox(height: 16,),
          FlatButton(
            onPressed: _checkForm,
            child: Container(
                height: 32,
                width: _screenWidth * 2/3,
                child: Center(child: Text(_isPhoneSent?GO_TO_LIST :GET_CODE))),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Utils.getPrimaryColor()),
                borderRadius: BorderRadius.circular(24)),
            textColor: Colors.white,
            color: Utils.getPrimaryColor(),
          )
        ],
      ),
    );
  }

  Form _getPhoneForm() {
    return Form(
      key: _phoneFormKey,
      child: TextFormField(
        controller: _phoneController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: formFieldPaddingHor,
                vertical: formFieldPaddingVert),
            hintText: ADD_PHONE_NUMBER),
      ),
      autovalidate: !_isFirstTry,
    );
  }


  Form _getCodeForm() {
    return Form(
      key: _codeFormKey,
      child: TextFormField(
        controller: _codeController,
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
    setState(() {
      _isPhoneSent = true;
    });
  }
}
