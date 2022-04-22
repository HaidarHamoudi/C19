import 'package:c19/features/covid_news/domain/entities/covid_news.dart';

class CovidNewsModel extends CovidNews {
  const CovidNewsModel({
    required String source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
  }) : super(
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
        );

  factory CovidNewsModel.fromJson(Map<String, dynamic> json) {
    return CovidNewsModel(
      source: json["source"]["name"] ?? '',
      author: json["author"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      url: json["url"] ?? '',
      urlToImage: json["urlToImage"] ?? '',
      publishedAt: json["publishedAt"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {"name": source},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    };
  }
}
