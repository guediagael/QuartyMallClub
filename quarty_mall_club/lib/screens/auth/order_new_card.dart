import 'package:flutter/material.dart';
import 'package:quarty_mall_club/Utils.dart';
import 'package:quarty_mall_club/string_resources.dart';

class NewCardScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _NewCardState();

}


class _NewCardState extends State{

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _isFirstTry, _isLoading;
  var _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Size _screenSize;
  double _screenWidth, _screenHeight;

  @override
  void initState() {
    _isFirstTry = true;
    _isLoading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(color: Colors.black,),
        title: Text(ORDER_A_CARD, style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: !_isLoading ? Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Utils.getPrimaryColor())
            ),
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: _screenHeight * 5/8,
            child: _buildForm(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: FlatButton(
              onPressed: _checkCredentials,
              child: Container(height: 32, width: _screenWidth /3, child: Center(child: Text(SEND))),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Utils.getPrimaryColor()),
                  borderRadius: BorderRadius.circular(24)),
              textColor: Colors.white,
              color: Utils.getPrimaryColor(),
            ),
          ),
        ],
      ) : Center( child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Utils.getPrimaryColor()),),),
    );
  }

  _checkCredentials(){

  }

  Widget _buildForm(){
    return Column(
      children: <Widget>[
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: NAME,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (name){
              if(name.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _surnameController,
            decoration: InputDecoration(
              labelText: SURNAME,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (surname){
              if(surname.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _birthdayController,
            decoration: InputDecoration(
              labelText: BIRTHDAY,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (birthday){
              if(birthday.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _cityController,
            decoration: InputDecoration(
              labelText: CITY,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (city){
              if(city.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _addressController,
            decoration: InputDecoration(
              labelText: ADDRESS,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (address){
              if(address.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: PHONE,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (phone){
              if(phone.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
        Container(
          height: _screenHeight * 4/49,
          child: TextFormField(
            autocorrect: false,
            controller: _emailController,
            decoration: InputDecoration(
              labelText: EMAIL,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (email){
              if(email.isEmpty) return ERROR_COMPULSORY_FIELD;
            },
          ),
        ),
      ],
    );
  }
}