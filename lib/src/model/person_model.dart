
import 'dart:convert';

PersonMovieModel personMovieModelFromJson(String str) => PersonMovieModel.fromJson(json.decode(str));


class PersonMovieModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  PersonMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PersonMovieModel.fromJson(Map<String, dynamic> json) => PersonMovieModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

class Result {
  bool adult;
  int id;
  String name;
  String originalName;
  ResultMediaType mediaType;
  double popularity;
  int gender;
  KnownForDepartment knownForDepartment;
  String profilePath;
  List<KnownFor> knownFor;

  Result({
    required this.adult,
    required this.id,
    required this.name,
    required this.originalName,
    required this.mediaType,
    required this.popularity,
    required this.gender,
    required this.knownForDepartment,
    required this.profilePath,
    required this.knownFor,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    mediaType: resultMediaTypeValues.map[json["media_type"]]!,
    popularity: json["popularity"]?.toDouble(),
    gender: json["gender"],
    knownForDepartment: knownForDepartmentValues.map[json["known_for_department"]]!,
    profilePath: json["profile_path"],
    knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
  );

}

class KnownFor {
  bool adult;
  String? backdropPath;
  int id;
  String? title;
  OriginalLanguage originalLanguage;
  String? originalTitle;
  String overview;
  String posterPath;
  KnownForMediaType mediaType;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  bool? video;
  double voteAverage;
  int voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  KnownFor({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.title,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalLanguage: originalLanguageValues.map[json["original_language"]]!,
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: knownForMediaTypeValues.map[json["media_type"]]!,
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
  );

}

enum KnownForMediaType {
  MOVIE,
  TV
}

final knownForMediaTypeValues = EnumValues({
  "movie": KnownForMediaType.MOVIE,
  "tv": KnownForMediaType.TV
});

enum OriginalLanguage {
  CN,
  EN,
  IT,
  KO
}

final originalLanguageValues = EnumValues({
  "cn": OriginalLanguage.CN,
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "ko": OriginalLanguage.KO
});

enum KnownForDepartment {
  ACTING,
  DIRECTING
}

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Directing": KnownForDepartment.DIRECTING
});

enum ResultMediaType {
  PERSON
}

final resultMediaTypeValues = EnumValues({
  "person": ResultMediaType.PERSON
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
