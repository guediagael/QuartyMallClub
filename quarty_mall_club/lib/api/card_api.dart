import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/network_utils.dart';

class CardApi {
  final String _CARD_CATEGORY_URL = BASE_URL + "/category/";
  final String _TAG = "CardApi";
  NetworkUtil _networkUtil = NetworkUtil();
  static CardApi _instance = CardApi.internal();

  CardApi.internal();

  factory CardApi() => _instance;

  Future<Map<String, dynamic>> getCards(String token) {
    assert(token != null);
    return _networkUtil.getData(_CARD_CATEGORY_URL, null, _cardError, header: {
      NetworkUtil.AUTHORIZATION_KEY: "Token $token",
      NetworkUtil.CONTENT_TYPE_KEY:
          NetworkUtil.HEADER_VALUE_APPLICATION_URL_ENCODED
    }).then((response) {
      if (response != null) {
        print("cards response data : $response");
        return response;
      }
    });
  }

  _cardError(dynamic error) {
    print(_TAG + "🤷‍♂️🤷‍♂️: $error");
  }
}
