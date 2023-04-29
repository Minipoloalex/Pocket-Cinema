enum MediaType { movie, series }

class Media {
  const Media(this.id,this.name,this.posterImage,this.backgroundImage,this.rating,this.nRatings,this.description,this.type);

  final String id;
  final String name;
  final String posterImage;
  final String backgroundImage;
  final String rating;
  final String nRatings;
  final String description;
  final MediaType type;

  Map<String, dynamic> toJson() => {
    'name': name,
    'posterUrl': posterImage,
    'type': type.toString(),
  };
}

