import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/network_utils.dart';

class PartnersApi{
  final String _partnersCategoryUrl = BASE_URL + "/partner/";
  final String _TAG = "PartnersApi";
  NetworkUtil _networkUtil = NetworkUtil();
  static PartnersApi _instance = PartnersApi.internal();

  PartnersApi.internal();

  factory PartnersApi() => _instance;

  Future<Map<String, dynamic>> getPartnersByCategory(String token, int categoryId) {
    assert(token != null);
    return _networkUtil.getData(_partnersCategoryUrl+"?category=${categoryId.toString()}", null, _cardError, header: {
      NetworkUtil.AUTHORIZATION_KEY: "Token $token",
      NetworkUtil.CONTENT_TYPE_KEY:
      NetworkUtil.HEADER_VALUE_APPLICATION_URL_ENCODED
    }).then((response) {
      if (response != null) {
        print("partners by cats response data : $response");
        return response;
      }
    });
  }

  _cardError(dynamic error) {
    print(_TAG + "🤷‍♂️🤷‍♂️: $error");
  }
}