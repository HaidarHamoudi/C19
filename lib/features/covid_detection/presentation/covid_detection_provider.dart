import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Detection with ChangeNotifier {
  bool _loading = true;
  File? _image;
  List? _output;
  final picker = ImagePicker();

  bool get loading {
    return _loading;
  }

  List? get output {
    return _output;
  }

  File? get image {
    return _image;
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: -0.5,
        imageMean: 255,
        imageStd: 127.5);
    _output = output;
    _loading = false;

    notifyListeners();
  }

  loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: 'assets/quantized_model3.tflite',
      labels: 'assets/labels.txt',
    );
    notifyListeners();
  }

  pickImage() async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (image == null) {
      return null;
    }

    _image = File(image.path);

    classifyImage(_image!);
    notifyListeners();
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      return null;
    }

    _image = File(image.path);

    classifyImage(_image!);
    notifyListeners();
  }
}
