import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/place_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewItem extends ConsumerStatefulWidget {
  const AddNewItem({super.key});

  @override
  ConsumerState<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends ConsumerState<AddNewItem> {
  final _textController = TextEditingController();
  PlaceLocation? _selectedLocation;
  File? _selectedImage;

//provider
  void _savePlace() {
    final enteredTitle = _textController.text;
    if (enteredTitle.isEmpty || _selectedImage == null||_selectedLocation==null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!,_selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    void dispose() {
      _textController.dispose();
      super.dispose();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Item'),
        ),
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _textController,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _savePlace,
                    icon: Icon(Icons.add),
                    label: const Text('Add Item'),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
              ),
              SizedBox(height: 20),
              LocationInput(onSelectLocation: (location) {
                _selectedLocation=location;
              },)
            ],
          ),
        ));
  }
}
