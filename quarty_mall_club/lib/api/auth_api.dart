import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/network_utils.dart';

class AuthApi {
  NetworkUtil _networkUtil = NetworkUtil();
  static const String _loginUrl = BASE_URL + "/tokenize/";
  static const String _registerUrl = BASE_URL + "/cards/";
  static AuthApi _instance = AuthApi.internal();

  AuthApi.internal();

  factory AuthApi() => _instance;

  Future<Map<String, dynamic>> getToken(int cardNumber) {
    Map<String, String> headers = {
      NetworkUtil.HEADER_ACCEPT_KEY: NetworkUtil.HEADER_ACCEPT_VALUE_ALL,
      NetworkUtil.HEADER_CACHE_CONTROL_KEY:
          NetworkUtil.HEADER_CACHE_CONTROL_VALUE_NO_CACHE
    };
    return _networkUtil
        .postData(_loginUrl, {"card": cardNumber}, authError)
        .then((response) {
      if (response != null) {
        print("response data: $response");
        return response;
      }
    });
  }

  Future<Map<String, dynamic>> register(String firstName, String lastName,
      String city, String birthday, int phoneNumber) {
    assert(firstName != null &&
        lastName != null &&
        city != null &&
        birthday != null &&
        phoneNumber != null);
    Map<String, dynamic> data = {
      KEY_FIRST_NAME: firstName,
      KEY_LAST_NAME: lastName,
      KEY_CITY: city,
      KEY_BIRTHDAY: birthday,
      KEY_PHONE_NUMBER: phoneNumber
    };


    return _networkUtil.postData(_registerUrl, data, authError).then((response){
      if(response!=null){
        print("response data: $response");
        return response;
      }
    });
  }

  authError(dynamic error) {
    print("🤷‍♂️🤷‍♂️: $error");
  }
}
