import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RandomImagePredictor(),
    );
  }
}

class RandomImagePredictor extends StatefulWidget {
  const RandomImagePredictor({Key? key}) : super(key: key);

  @override
  _RandomImagePredictorState createState() => _RandomImagePredictorState();
}

class _RandomImagePredictorState extends State<RandomImagePredictor> {
  late Interpreter _interpreter;
  String? _prediction;
  String? _currentImagePath;
  bool _isCatTurn = true;

  final _random = Random();
  List<String> _catImages = [];
  List<String> _dogImages = [];

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadImagePaths();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('efficientnetb0_model.tflite');
    } catch (e) {
      debugPrint("Error loading model: $e");
    }
  }

  Future<void> _loadImagePaths() async {
    try {
      final catManifestData = await rootBundle.loadString('AssetManifest.json');
      final catManifestMap = json.decode(catManifestData) as Map<String, dynamic>;

      _catImages = catManifestMap.keys
          .where((path) => path.startsWith('assets/test_dataset/cats/'))
          .toList();

      _dogImages = catManifestMap.keys
          .where((path) => path.startsWith('assets/test_dataset/dogs/'))
          .toList();

      setState(() {});
    } catch (e) {
      debugPrint("Error loading image paths: $e");
    }
  }

  Future<void> _predictRandomImage() async {
    if (_catImages.isEmpty || _dogImages.isEmpty) {
      setState(() {
        _prediction = "No images available";
      });
      return;
    }

    final imagePath = _isCatTurn
        ? _catImages[_random.nextInt(_catImages.length)]
        : _dogImages[_random.nextInt(_dogImages.length)];
    _isCatTurn = !_isCatTurn;

    try {
      final imageFile = await _loadImageFile(imagePath);
      final image = img.decodeImage(imageFile.readAsBytesSync());
      if (image == null) {
        setState(() {
          _prediction = "Image decoding failed";
        });
        return;
      }

      final resizedImage = img.copyResize(image, width: 224, height: 224);
      final input = resizedImage
          .getBytes(format: img.Format.rgb)
          .map((byte) => byte / 255.0)
          .toList()
          .reshape([1, 224, 224, 3]);

      final output = List.filled(1, 0.0).reshape([1, 1]);
      _interpreter.run(input, output);

      setState(() {
        _currentImagePath = imagePath;
        _prediction = output[0][0] > 0.5 ? "Dog" : "Cat";
      });
    } catch (e) {
      debugPrint("Prediction error: $e");
    }
  }

  Future<File> _loadImageFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getTemporaryDirectory()).path}/${assetPath.split('/').last}');
    return file.writeAsBytes(byteData.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Image Predictor'),
      ),
      body: Column(
        children: [
          if (_currentImagePath != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(_currentImagePath!),
            ),
          if (_prediction != null)
            Text(
              'Prediction: $_prediction',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ElevatedButton(
            onPressed: _predictRandomImage,
            child: const Text('Predict Random Image'),
          ),
        ],
      ),
    );
  }
}
