import 'dart:ffi';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/place_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaces extends ConsumerStatefulWidget {
  const FavoritePlaces({super.key});

  @override
  ConsumerState<FavoritePlaces> createState(){
    return _FavoritePlacesState();
  }
}


class _FavoritePlacesState extends ConsumerState<FavoritePlaces>
{

  late Future<void> _placesFuture;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture=ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  


  @override
  Widget build(BuildContext context) {
   final userPlaces=ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddNewItem(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('Favorite Places'),
      ),
      body:  Padding(
        padding:const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting?const Center(
            child: CircularProgressIndicator(),
          ): PlacesList(places: userPlaces))),
    );
  }

}