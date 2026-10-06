class PixabayImageModel {
  final int id;
  final String previewURL;
  final String webformatURL;
  final String largeImageURL;
  final String tags;
  final String user;
  final int views;
  final int downloads;
  final int likes;

  const PixabayImageModel({
    required this.id,
    required this.previewURL,
    required this.webformatURL,
    required this.largeImageURL,
    required this.tags,
    required this.user,
    required this.views,
    required this.downloads,
    required this.likes,
  });

  factory PixabayImageModel.fromJson(Map<String, dynamic> json) {
    return PixabayImageModel(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String,
      webformatURL: json['webformatURL'] as String,
      largeImageURL: json['largeImageURL'] as String,
      tags: json['tags'] as String,
      user: json['user'] as String,
      views: json['views'] as int,
      downloads: json['downloads'] as int,
      likes: json['likes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previewURL': previewURL,
      'webformatURL': webformatURL,
      'largeImageURL': largeImageURL,
      'tags': tags,
      'user': user,
      'views': views,
      'downloads': downloads,
      'likes': likes,
    };
  }

  static (List<PixabayImageModel> images, int total) listFromJson(Map<String, dynamic> json) {
    final hits = (json['hits'] as List? ?? [])
        .cast<Map<String, dynamic>>()
        .map(PixabayImageModel.fromJson)
        .toList();
    final total = json['total'] as int? ?? 0;

    return (hits, total);
  }
}
