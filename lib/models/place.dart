import 'package:zomato_search_app/models/location.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable(explicitToJson: true)
class Place {
  final String id;
  final String name;
  final String photos_url;
  final Location location;

  Place({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.photos_url,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
