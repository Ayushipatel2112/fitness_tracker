import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/photo_service.dart';
import '../services/permission_service.dart';

class TakePhotoScreen extends StatefulWidget {
  final String photoType; // 'front', 'back', 'side'
  
  const TakePhotoScreen({
    super.key,
    this.photoType = 'front',
  });

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  File? _capturedPhoto;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: IconButton(
            icon: Icon(Icons.close, size: 18.sp, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Take Photo',
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
          : Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: _capturedPhoto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Image.file(
                              _capturedPhoto!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 150.sp,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'No photo taken yet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                // Action Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _takePhotoFromCamera,
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          label: const Text(
                            'Camera',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF92A3FD),
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickPhotoFromGallery,
                          icon: const Icon(Icons.photo_library, color: Colors.white),
                          label: const Text(
                            'Gallery',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC58BF2),
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),

                // Save Button (only show if photo is captured)
                if (_capturedPhoto != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _savePhoto,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: const Text(
                          'Save Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20.h),
              ],
            ),
    );
  }

  Future<void> _takePhotoFromCamera() async {
    setState(() => _isLoading = true);

    // Check camera permission
    final hasPermission = await PermissionService.hasNotificationPermission();
    if (!hasPermission) {
      await PermissionService.requestNotificationPermission();
    }

    final photo = await PhotoService.takePhoto();
    
    setState(() {
      _capturedPhoto = photo;
      _isLoading = false;
    });

    if (photo == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to take photo')),
      );
    }
  }

  Future<void> _pickPhotoFromGallery() async {
    setState(() => _isLoading = true);

    final photo = await PhotoService.pickFromGallery();
    
    setState(() {
      _capturedPhoto = photo;
      _isLoading = false;
    });

    if (photo == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No photo selected')),
      );
    }
  }

  Future<void> _savePhoto() async {
    if (_capturedPhoto == null) return;

    setState(() => _isLoading = true);

    final savedPath = await PhotoService.savePhoto(
      _capturedPhoto!,
      widget.photoType,
    );

    setState(() => _isLoading = false);

    if (savedPath != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, savedPath);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save photo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
