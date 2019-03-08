
import 'package:flutter/material.dart';
import 'package:quarty_mall_club/string_resources.dart';

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _onboardingStep = 1;
  final String _stepOneTextHeader = "Карта клуба в телефоне";
  final String _stepOneTextBody = "Теперь карту Квартимолл-клуба\n"
      "не нужно носить с собой.\n"
      "Все скидки переносятся в телефон.";

  final String _stepTwoTextHeader = "Сэкономьте на ремонте";
  final String _stepTwoTextBody = "Наша дисконтная карта позволит вам\n "
      "получить скидки у партнеров «Квартимолла»\n "
      "и сэкономить на ремонте до 600 000 рублей.";
  final String _stepThreeTextHeader = "Просто покажите штрих-код";
  final String _stepThreeTextBody = "Откройте приложение\n"
      "и покажите на кассе штрих-код, тобы получить\n "
      "скидку у партнеров Квартимолл-клуба." ;

  double _screenWidth, _screenHeight;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(image: _getBackgroundAsset(), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTextHeader(),
            Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            _buildTextBody(),
            _buildIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Text(SKIP, style: TextStyle(color: Colors.white54),),
                  onTap: ()=>_skipOnboarding(),
                ),
                InkWell(
                  child: Row(
                    children: <Widget>[
                      Text(NEXT, style: TextStyle(color: Colors.white),),
                      Padding(padding: EdgeInsets.all(2)),
                      _buildImage('assets/pictures/right_arrow_big.png')
                    ],
                  ),
                  onTap: ()=> _moveToNextStep(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  AssetImage _getBackgroundAsset(){
    switch(_onboardingStep){
      case 1: return AssetImage('assets/pictures/onboarding2_big.png');
      case 2: return AssetImage('assets/pictures/onboarding3_big.png');
      case 3: return AssetImage('assets/pictures/onboarding2_big.png');
      default: return AssetImage('assets/pictures/onboarding2_big.png');
    }
  }

  Text _buildTextHeader(){
    var textString;
    switch(_onboardingStep){
      case 1: textString = _stepOneTextHeader;
      break;
      case 2: textString = _stepTwoTextHeader;
      break;
      case 3: textString = _stepThreeTextHeader;
      break;
      default: textString = _stepOneTextHeader;
    }
    return Text(textString, style: TextStyle(color: Colors.white),);
  }
  Text _buildTextBody(){
    var textString;
    switch(_onboardingStep){
      case 1: textString = _stepOneTextBody;
      break;
      case 2: textString = _stepTwoTextBody;
      break;
      case 3: textString = _stepThreeTextBody;
      break;
      default: textString = _stepOneTextBody;
    }
    return Text(textString, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,);
  }
  Container _buildIndicator(){
    var image;
    switch(_onboardingStep){
      case 1: image = _buildImage('assets/pictures/onboarding_one_indicator_big.png');
      break;
      case 2: image = _buildImage('assets/pictures/onboarding_two_indicator_big.png');
      break;
      case 3: image = _buildImage('assets/pictures/onboarding_three_indicator_big.png');
      break;
      default: image = _buildImage('assets/pictures/onboarding_one_indicator_big.png');

    }
    return Container(
      margin: EdgeInsets.all(40),
      width: .106 * _screenWidth, height: .0052 * _screenHeight, child: image,);
  }

  Image _buildImage(String url){
    return Image(image: AssetImage(url), fit: BoxFit.contain);
  }

  _skipOnboarding(){
    
  }

  _moveToNextStep(){
    if(_onboardingStep >=3) _skipOnboarding();
    else setState(() {
      _onboardingStep++;
    });
  }
}
