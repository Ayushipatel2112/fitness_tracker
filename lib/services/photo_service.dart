import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PhotoService {
  static const String _keyPhotos = 'progress_photos';
  static final ImagePicker _picker = ImagePicker();

  // Take photo from camera
  static Future<File?> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      print('Error taking photo: $e');
      return null;
    }
  }

  // Pick photo from gallery
  static Future<File?> pickFromGallery() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      print('Error picking photo: $e');
      return null;
    }
  }

  // Save photo permanently
  static Future<String?> savePhoto(File photo, String type) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${directory.path}/progress_photos');
      
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${type}_$timestamp${path.extension(photo.path)}';
      final savedPath = '${photosDir.path}/$fileName';

      await photo.copy(savedPath);

      // Save to preferences
      await _savePhotoMetadata(savedPath, type);

      return savedPath;
    } catch (e) {
      print('Error saving photo: $e');
      return null;
    }
  }

  // Save photo metadata
  static Future<void> _savePhotoMetadata(String photoPath, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final photosJson = prefs.getString(_keyPhotos);
    
    List<Map<String, dynamic>> photos = [];
    if (photosJson != null) {
      photos = List<Map<String, dynamic>>.from(json.decode(photosJson));
    }

    photos.add({
      'path': photoPath,
      'type': type,
      'date': DateTime.now().toIso8601String(),
    });

    await prefs.setString(_keyPhotos, json.encode(photos));
  }

  // Get all saved photos
  static Future<List<Map<String, dynamic>>> getAllPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    final photosJson = prefs.getString(_keyPhotos);
    
    if (photosJson == null) return [];
    
    return List<Map<String, dynamic>>.from(json.decode(photosJson));
  }

  // Get photos by type
  static Future<List<Map<String, dynamic>>> getPhotosByType(String type) async {
    final allPhotos = await getAllPhotos();
    return allPhotos.where((photo) => photo['type'] == type).toList();
  }

  // Delete photo
  static Future<void> deletePhoto(String photoPath) async {
    try {
      final file = File(photoPath);
      if (await file.exists()) {
        await file.delete();
      }

      // Remove from metadata
      final prefs = await SharedPreferences.getInstance();
      final photosJson = prefs.getString(_keyPhotos);
      
      if (photosJson != null) {
        List<Map<String, dynamic>> photos = 
            List<Map<String, dynamic>>.from(json.decode(photosJson));
        photos.removeWhere((photo) => photo['path'] == photoPath);
        await prefs.setString(_keyPhotos, json.encode(photos));
      }
    } catch (e) {
      print('Error deleting photo: $e');
    }
  }

  // Get latest photo by type
  static Future<Map<String, dynamic>?> getLatestPhoto(String type) async {
    final photos = await getPhotosByType(type);
    if (photos.isEmpty) return null;
    
    photos.sort((a, b) => 
      DateTime.parse(b['date']).compareTo(DateTime.parse(a['date']))
    );
    
    return photos.first;
  }
}
