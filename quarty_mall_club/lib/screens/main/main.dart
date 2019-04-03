import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quarty_mall_club/api/card_api.dart';
import 'package:quarty_mall_club/api/profile_api.dart';
import 'package:quarty_mall_club/model/card_category.dart';
import 'package:quarty_mall_club/model/profile.dart';
import 'package:quarty_mall_club/screens/main/profile_screen.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  final String TAG = "MainScreen";
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _screenWidth, _screenHeight;
  int _selectedIndex;
  String _title;
  ProfileApi profileApi;
  CardApi cardApi;

  @override
  void initState() {
    _title = "";
    _selectedIndex = 0;
    profileApi = ProfileApi.internal();
    cardApi = CardApi.internal();
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
          style: TextStyle(color: Utils.getMainTextColor()),
        ),
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
            switch (selected) {
              case 1:
                _title = SALES;
                break;
              case 2:
                _title = ABOUT;
                break;
              case 3:
                _title = PROFILE;
                break;
              default:
                _title = "";
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

  Container _buildBody() {
    print("current index: $_selectedIndex");
    switch (_selectedIndex) {
      case 0:
        return _buildMain();
        break;
      case 1:
        return _buildSales();
      case 2:
        return _buildAbout();
      case 3:
        return _buildProfile();
      default:
        _buildMain();
    }
  }

  Container _buildMain() {
//    TODO
  }

  Container _buildSales() {
//    TODO
  }

  Container _buildAbout() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16),
            height: _screenHeight / 2,
            width: _screenWidth,
            child: Image.asset(
              "assets/pictures/about_background_big.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(16, 24, 32, 24),
              child: Text(ABOUT_DESCRIPTION,
                  style: TextStyle(color: Utils.getMainTextColor()))),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: Colors.grey,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text(
                    "г. Казань \nПр. Победы, 157 \nТелефон: +7 (843) 225 37 37")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colors.grey,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text("kvartimall-club.ru \nEmail: info@kvartimall-club.ru")
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          Container(
            padding: EdgeInsets.only(left: 48),
            child: Text(
                "Режим работы: \nВт-Пт, 9:00-21:00 \nCб, Вс, Пн: 10:00-21:00"),
          )
        ],
      ),
    );
  }

  Container _buildProfile() {
    return Container(
      child: FutureBuilder<Profile>(
        future: _getProfile(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _showMessage(MSG_NO_CONNECTION);
            case ConnectionState.waiting:
              return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50.0),
                  child: new CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("error loading profile ${snapshot.error}");
                return _showMessage(MSG_SERVER_ERROR);
              } else {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return ProfileScreen(snapshot.data);
                }
              }
              break;
            case ConnectionState.active:
              break;
          }
        },
      ),
    );
  }

  Future<Profile> _getProfile() {
    _getCategories();
    return SharedPreferences.getInstance().then((sp){
      String token = sp.getString(SP_KEY_TOKEN);
      if(token !=null){
        return profileApi.getProfile(token).then((response){
          String firstName = response['first_name'];
          String lastName = response['last_name'];
          String city = "";
          String birthday = "";
          String phoneNumber = "";
          Profile profile = Profile(firstName, lastName, birthday, city, phoneNumber);
          return profile;
        },onError: _onError);
      }
    });
  }

  Future<List<CardCategory>> _getCategories(){
    return SharedPreferences.getInstance().then((sp){
      String token = sp.get(SP_KEY_TOKEN);
      if(token !=null){
        return cardApi.getCards(token).then((response){
          List results = response['results'];
          results.forEach((r)=> _mapResponseToCard(r));
        });
      }
    });
  }

  CardCategory _mapResponseToCard(Map<String, dynamic> result){
    int id = result['id'];
    String name = result['name'];
    String imageUrl = result['image'];
    CardCategory cardCategory = CardCategory(id, name, imageUrl);
    print("cardCat: ${cardCategory.name}");
    return cardCategory;
  }

  Widget _showMessage(String message) {
    return Center(
      child: Text(message),
    );
  }

  _onError(dynamic error){
    print("$MainScreen.TAG 🤷‍♂️🤷‍♂️: $error");
  }
}
