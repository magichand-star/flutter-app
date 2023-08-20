import '../../core/app_export.dart';

class ApiClient extends GetConnect {
  static const String _baseUrl = 'https://vast-stream-22281.herokuapp.com/';

  queryCities(String? city) async {
    if (city != null && city.isNotEmpty) {
      Response response = await get('${_baseUrl}cities/?query=$city');
      if (response.body['error'] != null)
        return [];
      else
        return response.body['cities'];
    }
  }

  getActivitiesAndHobbies() async {
    Response response = await get('${_baseUrl}activities');
    if (response.body != null && response.body['error'] != null)
      return [];
    else
      return response.body;
  }

  getNationalities() async {
    Response response = await get('${_baseUrl}nationalities');
    if (response.body != null && response.body['error'] != null)
      return [];
    else {
      return response.body;
    }
  }

  Future<String?> getJwt(String uid) async {
    Response response = await get(
      '${_baseUrl}jwt-token/?uid=$uid',
    );
    // log(response.body);

    return response.body['token'];
  }
}
