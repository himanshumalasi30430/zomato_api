import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_search_app/api/zomato_search_repo.dart';
import '../models/place.dart';

// Bloc -> Zomato Event

abstract class ZomatoEvent {}

class FetchPlacesEvent extends ZomatoEvent {
  String city;
  FetchPlacesEvent(this.city);
}

class FetchNearbyPlacesEvent extends ZomatoEvent {
  double _lat;
  double _long;
  FetchNearbyPlacesEvent(this._lat, this._long);
}

// Bloc -> Zomato State

abstract class ZomatoState {}

class InitState extends ZomatoState {}

class PlacesIsSearched extends ZomatoState {
  List<Place> _places;
  PlacesIsSearched(this._places);

  List<Place> get places => _places;
}

class PlacesAreLoading extends ZomatoState {}

class PlacesAreNotLoading extends ZomatoState {}

class ZomatoBloc extends Bloc<ZomatoEvent, ZomatoState> {
  ZomatoSearchRepo zomatoSearchRepo;
  ZomatoBloc(this.zomatoSearchRepo) : super(InitState());

  @override
  Stream<ZomatoState> mapEventToState(ZomatoEvent event) async* {
    if (event is FetchPlacesEvent) {
      yield PlacesAreLoading();
      try {
        List<Place> place = await zomatoSearchRepo.queryPlaces(event.city);
        yield PlacesIsSearched(place);
      } catch (e) {
        yield PlacesAreNotLoading();
      }
    } else if (event is FetchNearbyPlacesEvent) {
      yield PlacesAreLoading();
      try {
        List<Place> place =
            await zomatoSearchRepo.queryPlacesNearMe(event._lat, event._long);
        yield PlacesIsSearched(place);
      } catch (e) {
        yield PlacesAreNotLoading();
      }
    }
  }
}
