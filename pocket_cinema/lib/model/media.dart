enum MediaType { movie, series }

class Media {
  final String id;
  final String name;
  final String posterImage;
  final String? backgroundImage;
  final String? rating;
  final String? nRatings;
  final String? description;
  final MediaType? type;
  final String? trailer;
  final String? trailerDuration;

  Media(
      {required this.id,
      required this.name,
      required this.posterImage,
      this.backgroundImage,
      this.rating,
      this.nRatings,
      this.description,
      this.type,
      this.trailer,
      this.trailerDuration});

  Map<String, dynamic> toJson() => {
    'name': name,
    'posterUrl': posterImage,
    'type': type.toString(),
  };
}
