
import 'dart:convert';

PopularModel popularModelFromJson(String str) => PopularModel.fromJson(json.decode(str));


class PopularModel {
  int page;
  List<PopularResult> popularResults;
  int totalPages;
  int totalResults;

  PopularModel({
    required this.page,
    required this.popularResults,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
    page: json["page"],
    popularResults: List<PopularResult>.from(json["results"].map((x) => PopularResult.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class PopularResult {
  bool adult;
  int gender;
  int id;
  List<KnownFor> knownFor;
  String name;
  double popularity;
  String profilePath;

  PopularResult({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  factory PopularResult.fromJson(Map<String, dynamic> json) => PopularResult(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
    name: json["name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
  );

}

class KnownFor {
  bool? adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  MediaType mediaType;
  String originalLanguage;
  String? originalTitle;
  String overview;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double voteAverage;
  int voteCount;
  DateTime? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  KnownFor({
    this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    name: json["name"],
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
    originalName: json["original_name"],
  );

}

enum MediaType {
  MOVIE,
  TV
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
});

enum KnownForDepartment {
  ACTING
}

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING
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
