import 'dart:typed_data';

/// Stores bitmap data, only the actual image data.
class Bitmap {
  final int pixelSize;

  final int width;

  final int height;

  final Uint8List data;

  Bitmap(this.width, this.height, this.data, {this.pixelSize = 4});

  int size() {
    return (width * height) * pixelSize;
  }

  Bitmap copy() {
    return Bitmap(width, height, Uint8List.fromList(data), pixelSize: pixelSize);
  }
}