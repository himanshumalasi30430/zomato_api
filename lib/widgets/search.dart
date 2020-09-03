import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/zomato_bloc.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _city = '';

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final searchZomatoProvider = BlocProvider.of<ZomatoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search restaurants'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Restaurant'),
                onChanged: (value) {
                  _city = value;
                  // print(value);
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      // color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))),
                  onPressed: () {
                    if (_city.length != 0)
                      searchZomatoProvider.add(FetchPlacesEvent(_city));
                    else
                      print('Enter valid city');
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
