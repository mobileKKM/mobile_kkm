/// The picture formats the server takes for the profile photo.
enum PhotoType {
  jpeg('image/jpeg', 'jpg'),
  png('image/png', 'png'),
  webp('image/webp', 'webp');

  const PhotoType(this.contentType, this.extension);

  final String contentType;
  final String extension;
}

/// The largest photo the server takes: 5 MB.
const maxPhotoBytes = 5 * 1024 * 1024;

/// What [bytes] are, by how the file begins; null for anything the server
/// would not take.
PhotoType? photoTypeOf(List<int> bytes) {
  bool startsWith(List<int> signature, [int at = 0]) {
    if (bytes.length < at + signature.length) {
      return false;
    }
    for (var i = 0; i < signature.length; i++) {
      if (bytes[at + i] != signature[i]) {
        return false;
      }
    }
    return true;
  }

  if (startsWith(const [0xFF, 0xD8, 0xFF])) {
    return PhotoType.jpeg;
  }
  if (startsWith(const [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
    return PhotoType.png;
  }
  // "RIFF", four bytes of length, "WEBP".
  if (startsWith(const [0x52, 0x49, 0x46, 0x46]) && startsWith(const [0x57, 0x45, 0x42, 0x50], 8)) {
    return PhotoType.webp;
  }
  return null;
}
