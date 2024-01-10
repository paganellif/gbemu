import 'package:gbemu/emulator/graphics/palette.dart';

class GBCPalette implements Palette {
  @override
  late List<int> colors;

  GBCPalette(List<int> colors) {
    if(colors.length < 4) {
      throw Exception("Colors must be of length 4.");
    }

    colors = colors;
  }

  @override
  int getColor(int number)
  {
    return this.colors[number];
  }
}
