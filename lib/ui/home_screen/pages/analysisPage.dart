import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'diagnosisPage.dart';
import 'homePage.dart';
import 'dart:math';

class AnalysisPage extends StatefulWidget {
  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  File? _image;

  List<String> fakeResults = [
    "Healthy skin detected",
    "Mild irritation detected",
    "Possible eczema detected",
    "Suspicious skin condition detected",
    "Dry skin identified"
  ];

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));

      // توليد نتيجة وهمية
      String result = fakeResults[Random().nextInt(fakeResults.length)];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosisPage(
            image: _image!,
            result: result,
            data: DateTime.now(),
          ),
        ),
      );
    }
  }

  // Function to capture image from camera
  Future<void> _captureImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));

      // توليد نتيجة وهمية
      String result = fakeResults[Random().nextInt(fakeResults.length)];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosisPage(
            image: _image!,
            result: result,
            data: DateTime.now(),
          ),
        ),
      );
    }
  }

  // عرض الصورة أو أيقونة بديلة
  Widget imagePreview(File? image) {
    return image == null
        ? Icon(Icons.image_not_supported, size: 150, color: AppColors.greyColor)
        : Image.file(image, height: 300, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
    ),
    body: Center(
    child: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    imagePreview(_image),
    SizedBox(height: 20),
    _image == null
    ? Column(
    children: [
    SizedBox(
    width: 350,
    height: 50,
    child: ElevatedButton.icon(
    onPressed: _pickImageFromGallery,
    icon: Icon(Icons.photo_library_rounded, color: AppColors.whiteColor),
    label: Text('Pick from Gallery', style: TextStyle(color: AppColors.whiteColor)),
    style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ),
    ),
    ),
    SizedBox(height: 15),
    SizedBox(
    width: 350,
    height: 50,
    child: ElevatedButton.icon(
    onPressed: _captureImageFromCamera,
    icon: Icon(Icons.camera_alt, color: AppColors.whiteColor),
    label: Text('Take a Photo', style: TextStyle(color: AppColors.whiteColor)),
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ),
    ),
    ),
    ],
    )
        : Text("Image already selected!"),
    ],
    ),
    ),
    ),
    );
  }
}