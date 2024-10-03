import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageFunctionality extends StatefulWidget {
  const ImageFunctionality({super.key});

  @override
  State<ImageFunctionality> createState() => _ImageFunctionalityState();
}

class _ImageFunctionalityState extends State<ImageFunctionality> {
  List<File> _imageFiles = [];
  final List<String> _imageUrls = [];

  Future <void> _pickImage (ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      }
    });
  }

// image uploading to cloudinary
  Future <void> _uploadImages() async {
    for (var imageFile in _imageFiles) {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dzfbycabj/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'imagePreset'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = json.decode(responseString);
        final url = jsonMap['url'];
        _imageUrls.add(url);
      } else {
        print('Failed to upload image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
