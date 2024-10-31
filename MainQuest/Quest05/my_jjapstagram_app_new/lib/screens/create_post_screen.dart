import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'post.dart';

class CreatePostScreen extends StatefulWidget {
  final Function(Post) onPostCreated;

  CreatePostScreen({Key? key, required this.onPostCreated}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 선택된 이미지 파일 설정
      });
    }
  }

  void _submitPost() {
    if (_image != null && _descriptionController.text.isNotEmpty) {
      final newPost = Post(
        imagePath: _image!.path,
        description: _descriptionController.text.trim(),
      );
      widget.onPostCreated(newPost);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시물이 업로드되었습니다.')),
      );
      setState(() {
        _image = null;
        _descriptionController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지와 설명을 모두 입력하세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _image != null
              ? Image.file(_image!)
              : Placeholder(fallbackHeight: 200.0),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('이미지 선택'),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '설명 입력'),
            ),
          ),
          ElevatedButton(
            onPressed: _submitPost,
            child: Text('게시'),
          ),
        ],
      ),
    );
  }
}
