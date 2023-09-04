import 'package:movie_app/src/provider/app_provider.dart';

import '../model/http_result.dart';

class Repository{
  final AppProvider _appProvider =AppProvider();
  Future<HttpResult> getMoviePopular() => _appProvider.getMoviePopular();
}