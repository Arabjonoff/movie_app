import 'package:movie_app/src/model/http_result.dart';
import 'package:movie_app/src/model/movie_popular.dart';
import 'package:movie_app/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class PopularBloc{
  final Repository _repository = Repository();
  final _fetchPopular = PublishSubject<PopularModel>();
  Stream<PopularModel> get getPopular => _fetchPopular.stream;


  getMoviePopular()async{
    HttpResult response = await _repository.getMoviePopular();
    if( response.isSuccess){
      var data = PopularModel.fromJson(response.result);
      _fetchPopular.sink.add(data);
    }
  }


}


final popularBloc = PopularBloc();
