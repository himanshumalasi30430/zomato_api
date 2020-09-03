import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_search_app/api/zomato_search_repo.dart';
import 'package:zomato_search_app/bloc/zomato_bloc.dart';
import 'package:zomato_search_app/widgets/search.dart';
import 'package:geolocator/geolocator.dart';
import 'widgets/list_search_item.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ZomatoBloc(ZomatoSearchRepo()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zomato Search',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position _position;

  searchLocation() async {
    _position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final searchZomatoProvider = BlocProvider.of<ZomatoBloc>(context);
    searchZomatoProvider
        .add(FetchNearbyPlacesEvent(_position.latitude, _position.longitude));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchLocation();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final searchZomatoProvider = BlocProvider.of<ZomatoBloc>(context);
    var height = MediaQuery.of(context).size.height - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text('Zomato Place'),
      ),
      body: ListSearchItem(),
      floatingActionButton: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                tooltip: 'Near Me',
                heroTag: null,
                child: Icon(Icons.location_on),
                onPressed: () {
                  searchZomatoProvider.add(FetchNearbyPlacesEvent(
                      _position.latitude, _position.longitude));
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              FloatingActionButton(
                tooltip: 'Search New Restraunt',
                heroTag: null,
                child: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Search()));
                },
              ),
            ]),
      ),
    );
  }
}
