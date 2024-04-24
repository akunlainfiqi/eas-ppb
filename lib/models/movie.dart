class MovieFields {
  static final List<String> values = [
    /// Add all fields
    id, title, dateCreated, imageUrl, description, dateUpdated
  ];

  static const String id = '_id';
  static const String imageUrl = 'image_url';
  static const String title = 'title';
  static const String description = 'description';
  static const String dateCreated = 'date_created';
  static const String dateUpdated = 'date_updated';
}

class Movie {
  final int? id;
  final String title;
  final DateTime dateCreated;
  final String imageUrl;
  final String description;
  final DateTime? dateUpdated;

  Movie({
    this.id,
    required this.title,
    required this.dateCreated,
    required this.dateUpdated,
    required this.imageUrl,
    required this.description,
  });

  Movie copy({
    int? id,
    String? title,
    String? imageUrl,
    String? description,
    DateTime? dateCreated,
  }) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        dateCreated: dateCreated ?? this.dateCreated,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        dateUpdated: DateTime.now(),
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
        id: json[MovieFields.id] as int,
        title: json[MovieFields.title] as String,
        dateCreated: DateTime.parse(json[MovieFields.dateCreated] as String),
        imageUrl: json[MovieFields.imageUrl] as String,
        description: json[MovieFields.description] as String,
        dateUpdated: DateTime.parse(json[MovieFields.dateUpdated] as String),
      );

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.title: title,
        MovieFields.imageUrl: imageUrl,
        MovieFields.description: description,
        MovieFields.dateCreated: dateCreated.toIso8601String(),
        MovieFields.dateUpdated: dateUpdated?.toIso8601String(),
      };
}
