/// Palette is used to store the gameboy palette colors.
///
/// Each palette is composed of four colors, for classic gameboy gray scale colors are stored.
///
/// For gameboy color the palette stores RGB colors.
abstract class Palette {
  late List<int> colors;

  /// Gets the RGBA color associated to a given index.
  int getColor(int number);
}