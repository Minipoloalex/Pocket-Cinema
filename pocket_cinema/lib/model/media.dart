enum MediaType { movie, series }

class Media {
  final String id;
  final String name;
  final String posterImage;
  final String? backgroundImage;
  final String? rating;
  final int? nRatings;
  final String? description;
  final MediaType? type;
  final String? trailer;
  final String? trailerDuration;
  final String? releaseDate;
  bool? watched;

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
      this.trailerDuration,
      this.releaseDate,
      this.watched});

  Map<String, dynamic> toJson() => {
    'name': name,
    'posterUrl': posterImage,
    'type': type.toString(),
  };
  
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      other is Media && runtimeType == other.runtimeType && id == other.id;
  }
  @override
  int get hashCode => id.hashCode;
}
