class City {
  City({this.name, this.lon, this.lat, this.country});

  String? name;
  double? lon;
  double? lat;
  String? country;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lon": lon,
        "lat": lat,
        "country": country,
      };
}
