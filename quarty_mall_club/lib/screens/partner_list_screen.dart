import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quarty_mall_club/api/partners_api.dart';
import 'package:quarty_mall_club/model/card_category.dart';
import 'package:quarty_mall_club/model/partner.dart';
import 'package:quarty_mall_club/screens/partner_details_screen.dart';
import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerListScreen extends StatelessWidget {
  final CardCategory cardCategory;
  double _screenHeight, _screenWidth;
  final List<Partner> partners = List<Partner>();
  PartnerListScreen(this.cardCategory);
  PartnersApi _partnersApi = PartnersApi.internal();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _context = context;
    _screenWidth = size.width;
    _screenHeight = size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: Utils.getMainBackgroundColor()));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Utils.getMainTextColor(),),
          centerTitle: true,
          backgroundColor: Utils.getMainBackgroundColor(),
          title: Title(color: Utils.getMainBackgroundColor(), child: Text(cardCategory.name, style: TextStyle(color: Utils.getMainTextColor()),)),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Utils.getMainBackgroundColor(),
          child: FutureBuilder<List<Partner>>(
            future: _getPartners(),
            builder: (ctx, snapshot){
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
                    print("error loading partners ${snapshot.error}");
                    return _showMessage(MSG_SERVER_ERROR);
                  } else {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                          itemBuilder: (ctx,index){
                        return _buildPartnerCard(snapshot.data[index]);
                      });
                    }
                  }
                  break;
                case ConnectionState.active:
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Partner>> _getPartners() {
    return SharedPreferences.getInstance().then((sp) {
      String token = sp.get(SP_KEY_TOKEN);
      return _partnersApi.getPartnersByCategory(token, cardCategory.id).then((response){
        List<dynamic> results = response['results'];
        return results.map((r)=> _mapResponseToModel(r)).toList();
      });
    });
  }

  InkWell _buildPartnerCard(Partner partner) {
    return InkWell(
      onTap: () => _showDetails(partner),
      child: Container(
        height: _screenHeight / 3,
        width: (_screenWidth * 3 / 7) - 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: _screenHeight * 6 / 25,
              width: _screenWidth - 16,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Hero(
                tag: partner.name,
                child: CachedNetworkImage(
                  key: Key("listElement"+partner.toString()),
                  imageUrl: partner.image,
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            Text(partner.name)
          ],
        ),
      ),
    );
  }

  _showDetails(Partner partner){

    Navigator.of(_context).push(MaterialPageRoute(builder: (ctx)=> PartnerDetails(partner)));
  }

  Partner _mapResponseToModel(Map<String, dynamic> remotePartner){
    int id = remotePartner['id'];
    String name = remotePartner['name'];
    String description = remotePartner['description'];
    String image = remotePartner['image'];
    Partner partner = Partner(id, name, description, image);
    print("maping partner: $partner");
    return partner;
  }

  Widget _showMessage(String message) {
    return Center(
      child: Text(message),
    );
  }
}
