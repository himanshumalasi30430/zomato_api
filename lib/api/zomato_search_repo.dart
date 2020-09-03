import 'package:http/http.dart' as http;
import '../models/place.dart';
import 'dart:convert';

class ZomatoSearchRepo {
  Future<List<Place>> queryPlaces(String city) async {
    var result = await http.get(
        'https://developers.zomato.com/api/v2.1/search?q=$city',
        headers: {'user-key': 'fcaa5187b6eeb623f459ffd9409adfd2'});
    if (result.statusCode != 200) {
      throw Exception();
    }
    var responseBody = result.body;
    var responseConvert = jsonDecode(responseBody);
    var restaurants = responseConvert['restaurants'];
    // [ {}, {}, .....]
    List<Place> places = getPlacesList(restaurants);
    return places;
  }

  Future<List<Place>> queryPlacesNearMe(
      double latitude, double longitude) async {
    var result = await http.get(
        'https://developers.zomato.com/api/v2.1/geocode?lat=$latitude&lon=$longitude',
        headers: {
          'user-key': 'fcaa5187b6eeb623f459ffd9409adfd2',
        });
    if (result.statusCode != 200) {
      throw Exception();
    }
    var responseBody = result.body;
    var responseConvert = jsonDecode(responseBody);
    var restaurants = responseConvert['nearby_restaurants'];
    List<Place> places = getPlacesList(restaurants);
    return places;
  }

  List<Place> getPlacesList(restraunts) {
    List<Place> places = [];
    for (int i = 0; i < restraunts.length; i++) {
      var restaurant = restraunts[i]['restaurant'];
      places.add(Place.fromJson(restaurant));
    }
    return places;
  }
}
