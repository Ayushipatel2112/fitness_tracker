import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../services/photo_service.dart';

class PhotoComparisonScreen extends StatefulWidget {
  const PhotoComparisonScreen({super.key});

  @override
  State<PhotoComparisonScreen> createState() => _PhotoComparisonScreenState();
}

class _PhotoComparisonScreenState extends State<PhotoComparisonScreen> {
  Map<String, dynamic>? _photo1;
  Map<String, dynamic>? _photo2;
  List<Map<String, dynamic>> _allPhotos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final photos = await PhotoService.getAllPhotos();
    setState(() {
      _allPhotos = photos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18.sp, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Photo Comparison',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Instructions
                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF92A3FD).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0xFF92A3FD),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Select two photos to compare your progress',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Photo 1 Selection
                  Text(
                    'Before Photo',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => _selectPhoto(1),
                    child: Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: _photo1 != null
                              ? const Color(0xFF92A3FD)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: _photo1 != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(18.r),
                              child: Image.file(
                                File(_photo1!['path']),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 50.sp,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Tap to select photo',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_photo1 != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Date: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(_photo1!['date']))}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  SizedBox(height: 25.h),

                  // Photo 2 Selection
                  Text(
                    'After Photo',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => _selectPhoto(2),
                    child: Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: _photo2 != null
                              ? const Color(0xFFC58BF2)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: _photo2 != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(18.r),
                              child: Image.file(
                                File(_photo2!['path']),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 50.sp,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Tap to select photo',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_photo2 != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Date: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(_photo2!['date']))}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  SizedBox(height: 30.h),

                  // Compare Button
                  if (_photo1 != null && _photo2 != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _showComparison,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF92A3FD),
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Compare Photos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  void _selectPhoto(int photoNumber) {
    if (_allPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No photos available. Take some photos first!'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Photo ${photoNumber == 1 ? "(Before)" : "(After)"}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 300.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: _allPhotos.length,
                itemBuilder: (context, index) {
                  final photo = _allPhotos[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (photoNumber == 1) {
                          _photo1 = photo;
                        } else {
                          _photo2 = photo;
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.r),
                        child: Image.file(
                          File(photo['path']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComparison() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Progress Comparison',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Before',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF92A3FD),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.file(
                            File(_photo1!['path']),
                            height: 200.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          DateFormat('MMM dd').format(
                            DateTime.parse(_photo1!['date']),
                          ),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'After',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFC58BF2),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.file(
                            File(_photo2!['path']),
                            height: 200.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          DateFormat('MMM dd').format(
                            DateTime.parse(_photo2!['date']),
                          ),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF92A3FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
