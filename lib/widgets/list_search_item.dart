import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/zomato_bloc.dart';

class ListSearchItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZomatoBloc, ZomatoState>(builder: (context, state) {
      if (state is InitState) {
        return Container(
          child: Center(
            child: LinearProgressIndicator(),
          ),
        );
      } else if (state is PlacesAreLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PlacesAreNotLoading) {
        return Center(
          child: Text('Places are not loading'),
        );
      } else if (state is PlacesIsSearched) {
        return ListView.builder(
            itemCount: state.places.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: ListTile(
                  leading: Icon(
                    Icons.restaurant,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(state.places[index].name),
                  subtitle: Text(state.places[index].location.address),
                  trailing: Icon(
                    Icons.restaurant_menu_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            });
      }
    });
  }
}
