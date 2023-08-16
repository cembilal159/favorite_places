import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onPickImage});

  final void Function(File image) onPickImage;

  

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final _pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imagePicker == null) {
      return;
    }

    setState(() {
      _selectedImage = File(_pickedImage!.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      onPressed: _takePicture,
      label: const Text('Take a picture'),
    );

    if (_selectedImage != null) {
      content = Image.file(_selectedImage!, fit: BoxFit.cover,width: double.infinity,height: double.infinity,);
    }

    return GestureDetector(
      onTap: _takePicture,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.2),
          )),
          height: 250,
          width: 360,
          child: content),
    );
  }
}
