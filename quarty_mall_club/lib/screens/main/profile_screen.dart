import 'package:flutter/material.dart';
import 'package:quarty_mall_club/string_resources.dart';

class ProfileScreen extends StatefulWidget {
  String _name, _surname, _birthday, _city, _phone;

  ProfileScreen(
      String name, String surname, String birthday, String city, String phone) {
    this._name = name;
    this._surname = surname;
    this._birthday = birthday;
    this._city = city;
    this._phone = phone;
  }

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditMode;
  bool _isFirstTry;
  var _formState = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String _name, _surname, _birthday, _city, _phone;

  @override
  void initState() {
    _isEditMode = false;
    _isFirstTry = true;
    _name = widget._name;
    _surname = widget._surname;
    _birthday = widget._birthday;
    _city = widget._city;
    _phone = widget._phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: _isEditMode ? _buildEditMode() : _buildViewOnlyMode(),
      ),
    );
  }

  Column _buildViewOnlyMode() {
    return Column(
      children: <Widget>[
        Card(
          color: Colors.white,
          borderOnForeground: true,
          child: Container(
            child: Column(
              children: <Widget>[
                Text(_name),
                Text(_surname),
                Text(_birthday),
                Text(_city),
                Text(_phone),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isEditMode = true;
            });
          },
          child: Center(child: Text(EDIT)),
        )
      ],
    );
  }

  Column _buildEditMode() {
    return Column(
      children: <Widget>[
        Container(
//          height: _screenHeight * 4 / 49,
          child: TextFormField(
            autocorrect: !_isFirstTry,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: _name,
            ),
            validator: (name) {
              if (name.isEmpty) return ERROR_COMPULSORY_FIELD;
              if (name.trim().length > 30) return TO_LONG;
            },
          ),
        ),
        Container(
//          height: _screenHeight * 4 / 49,
          child: TextFormField(
            autocorrect: !_isFirstTry,
            controller: _surnameController,
            decoration: InputDecoration(
              labelText: _surname,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (surname) {
              if (surname.isEmpty) return ERROR_COMPULSORY_FIELD;
              if (surname.trim().length > 30) return TO_LONG;
            },
          ),
        ),
        Container(
//          height: _screenHeight * 4 / 49,
          child: TextFormField(
            autocorrect: !_isFirstTry,
            controller: _birthdayController,
            decoration: InputDecoration(
              labelText: _birthday,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (birthday) {
              if (birthday.isEmpty) return ERROR_COMPULSORY_FIELD;
              if (birthday.trim().length > 10) return TO_LONG;
//TODO: add watcher
            },
          ),
        ),
        Container(
//          height: _screenHeight * 4 / 49,
          child: TextFormField(
            autocorrect: !_isFirstTry,
            controller: _cityController,
            decoration: InputDecoration(
              labelText: _city,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (city) {
              if (city.isEmpty) return ERROR_COMPULSORY_FIELD;
              if (city.trim().length > 30) return TO_LONG;
            },
          ),
        ),
        Container(
//          height: _screenHeight * 4 / 49,
          child: TextFormField(
            autocorrect: !_isFirstTry,
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: _phone,
//            errorText: ERROR_COMPULSORY_FIELD
            ),
            validator: (phone) {
              if (phone.isEmpty) return ERROR_COMPULSORY_FIELD;
              if (phone.trim().length != 16) return TO_LONG;
            },
          ),
        ),
      ],
    );
  }
}
