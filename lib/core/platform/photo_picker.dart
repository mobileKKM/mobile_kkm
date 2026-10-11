import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

enum PhotoSource { camera, gallery }

/// A photo from the camera or the gallery, through the system's own screens.
class PhotoPicker {
  const PhotoPicker();

  /// The picture's bytes, or null when the user backed out.
  ///
  /// It is scaled down to what an ID photo needs, which also turns the
  /// formats a phone's camera writes (HEIC) into JPEG.
  Future<Uint8List?> pick(PhotoSource source) async {
    final file = await ImagePicker().pickImage(
      source: switch (source) {
        PhotoSource.camera => ImageSource.camera,
        PhotoSource.gallery => ImageSource.gallery,
      },
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.front,
    );
    return file?.readAsBytes();
  }
}
