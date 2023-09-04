import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/model/http_result.dart';

class AppProvider {
  final String _baseUrl = "https://api.themoviedb.org/";
  _getRequests(url) async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZDI5ZGE0ZDVmMmNiNTA3NGRkOTA5NzlkMjIzNWNjZCIsInN1YiI6IjYzNGZlZGM5YmU0YjM2MDA4NGU0OGNjZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ip8Nk-uIKu4Wfz4mFFFd1ohboe_s9Fd6OGlH6B0Nstk"
    });
    return _result(response);
  }
  _result(http.Response response){
    print(response.body);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 300) {

      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(
          utf8.decode(response.bodyBytes),
        ),
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: json.decode(
          utf8.decode(response.bodyBytes),
        ),
      );
    }
  }


  Future<HttpResult> getMoviePopular()async{
    String url = "${_baseUrl}3/person/popular?language=en-US&page=1";
    return await _getRequests(url);
  }

}
