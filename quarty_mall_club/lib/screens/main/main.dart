import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/commons.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _screenWidth, _screenHeight;
  int _selectedIndex;
  String _title;

  @override
  void initState() {
    _title = "";
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: Utils.getMainBackgroundColor()));
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              _title,
              style: TextStyle(color: Utils.getMainTextColor()),),
            elevation: 0,
            backgroundColor: Utils.getMainBackgroundColor(),
          ),
          body: _buildBody(),
          backgroundColor: Utils.getMainBackgroundColor(),
          bottomNavigationBar: _buildMainNavigation(),
    ));
  }

  Widget _buildMainNavigation() {
    //TODO: make the corners rounded
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: _getBottomNavigationItems(),
        type: BottomNavigationBarType.fixed,
        fixedColor: Utils.getPrimaryColor(),
        onTap: (selected) {
          setState(() {
            _selectedIndex = selected;
            switch(selected){
              case 1: _title = SALES;
              break;
              case 2: _title = ABOUT;
              break;
              case 3: _title = PROFILE;
              break;
              default: _title = "";
            }
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    var navBarList = List<BottomNavigationBarItem>();

    var homeItem = BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Utils.getMainTextColor()),
        activeIcon: Icon(Icons.home, color: Utils.getPrimaryColor()),
        title: Text(HOME_SCREEN));
    navBarList.add(homeItem);

    var salesItem = BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("assets/pictures/percentage_medium.png"),
            color: Utils.getMainTextColor()),
        activeIcon: ImageIcon(
            AssetImage("assets/pictures/percentage_medium.png"),
            color: Utils.getPrimaryColor()),
        title: Text(SALES));
    navBarList.add(salesItem);

    var aboutItem = BottomNavigationBarItem(
        icon: Icon(Icons.credit_card, color: Utils.getMainTextColor()),
        activeIcon: Icon(Icons.credit_card, color: Utils.getPrimaryColor()),
        title: Text(ABOUT));
    navBarList.add(aboutItem);

    var profileItem = BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Utils.getMainTextColor(),
        ),
        activeIcon: Icon(
          Icons.person,
          color: Utils.getPrimaryColor(),
        ),
        title: Text(PROFILE));
    navBarList.add(profileItem);

    return navBarList;
  }

  Container _buildBody(){
    print("current index: $_selectedIndex");
    switch(_selectedIndex){
      case 0: return _buildMain();
      break;
      case 1: return _buildSales();
      case 2: return _buildAbout();
      case 3: return _buildProfile();
      default :  _buildMain();
    }
  }
  Container _buildMain() {

//    TODO
  }

  Container _buildSales() {

//    TODO
  }

  Container _buildAbout() {
  }

  Container _buildProfile() {
//    TODO
  }
}
