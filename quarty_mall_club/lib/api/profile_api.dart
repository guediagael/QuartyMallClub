import 'package:quarty_mall_club/string_resources.dart';
import 'package:quarty_mall_club/utils/network_utils.dart';

class ProfileApi{
  NetworkUtil _networkUtil = NetworkUtil();
  static const String _showProfileUrl = BASE_URL +"/whoami";
  static const String _editProfileUrl = BASE_URL +"/whoami";
  static ProfileApi _instance = ProfileApi.internal();
  ProfileApi.internal();
  factory ProfileApi() => _instance;


  Future<Map<String, dynamic>> getProfile(String token){
    assert (token!=null);
    return _networkUtil.getData(_showProfileUrl, null, _profileError,
        header: {NetworkUtil.AUTHORIZATION_KEY : "Token $token"}).then((response){
          if(response !=null){
            print("profile response data: $response");
            return response;
          }
    });
  }

  _profileError(dynamic error){
    print("🤷‍♂️🤷‍♂️: $error");
  }
}