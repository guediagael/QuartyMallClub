import 'package:flutter/material.dart';
import 'package:quarty_mall_club/model/profile.dart';
import 'package:quarty_mall_club/string_resources.dart';

class ProfileScreen extends StatefulWidget {
  Profile _profile;

  ProfileScreen(Profile profile) {
    this._profile = profile;
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

  double _screenWidth, _screenHeight;
  String _name, _surname, _birthday, _city, _phone;

  @override
  void initState() {
    _isEditMode = false;
    _isFirstTry = true;
    _name = widget._profile.name;
    _surname = widget._profile.surname;
    _birthday = widget._profile.birthday;
    _city = widget._profile.city;
    _phone = widget._profile.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
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
          margin: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          borderOnForeground: true,
          child: Container(
            width: _screenWidth,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name),
                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Text(_surname),
//                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
//                Text(_birthday),
//                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
//                Text(_city),
//                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
//                Text(_phone),
              ],
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
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
