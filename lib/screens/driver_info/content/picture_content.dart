import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_texi_tracker/screens/driver_info/content/input_card.dart';

class PictureContent extends StatefulWidget {
  List<File> selectedImages = [];
   PictureContent({
    super.key, required this.selectedImages
  });

  @override
  _PictureContentState createState() => _PictureContentState();
}

class _PictureContentState extends State<PictureContent> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (widget.selectedImages.length > 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only select up to 4 images.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.camera,imageQuality: 90);

    if (pickedFile != null) {
      setState(() {
        widget.selectedImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 20, bottom: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Take 4 Pictures, a picture of both sides, front, and back of the car",
                        style: TextStyle(
                            fontSize: 16.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Bi-Weekly car reports are important to get paid",
                  style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          if (widget.selectedImages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(widget.selectedImages.length, (index) {
                  return Container(
                    width: 80.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(widget.selectedImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          GestureDetector(
            onTap: _pickImage,
            child: InputCard(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.blue.shade300,
                    size: 18,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text(
                    "Tap to select",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
