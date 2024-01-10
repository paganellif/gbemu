import 'package:flutter/material.dart';
import 'package:gbemu/utils/color_converter.dart';

class PaletteColorsRow {
  /// The background palette data.
  List<int> bg;

  /// The object 0 palette data.
  List<int> obj0;

  /// The object 1 palette data.
  List<int> obj1;

  ///
  /// @param bg   Background palette data.
  /// @param obj0 Object palette 1 data.
  /// @param obj1 Object palette 2 data.
  PaletteColorsRow(this.bg, this.obj0, this.obj1);
}

/// Palette colour data for non-colour Gameboy ROMs.
class PaletteColors {
  static final PaletteColors _singleton = PaletteColors._internal();
  static final PaletteColors instance = _singleton;

  ///Mapping of colours by 8-bit game hash.
  static final List<PaletteColorsRow> list = _create();

  factory PaletteColors() {
    return _singleton;
  }

  PaletteColors._internal();

  /// Get the correct palette color from the game color hash.
  ///
  /// Calculated from the last byte of the sum of the title name.
  PaletteColorsRow getByHash(int hash) {
    return list[hash];
  }

  /// Initialize the color palette.
  ///
  /// Fill values into the list.
  static List<PaletteColorsRow> _create() {
    // Default colours
    List<int> defaultColors = [ColorConverter.toRGB(Colors.white), ColorConverter.toRGB(Colors.lightGreen), ColorConverter.toRGB(Colors.green), ColorConverter.toRGB(Colors.black)];
    PaletteColorsRow defaultPaletteRow = PaletteColorsRow(defaultColors, defaultColors, defaultColors);

    List<PaletteColorsRow> paletteColors = List<PaletteColorsRow>.filled(0x100, defaultPaletteRow);

    paletteColors[0xFF] = PaletteColorsRow([0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000]);
    paletteColors[0x71] = PaletteColorsRow([0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000]);
    paletteColors[0xDB] = PaletteColorsRow([0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000]);
    paletteColors[0x15] = PaletteColorsRow([0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000]);
    paletteColors[0x88] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xA59CFF, 0xFFFF00, 0x006300, 0x000000]);
    paletteColors[0x16] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x92] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x35] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x75] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x99] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x0C] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0xB7] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x67] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0xE8] = PaletteColorsRow([0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF]);
    paletteColors[0x28] = PaletteColorsRow([0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF]);
    paletteColors[0xA5] = PaletteColorsRow([0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF], [0x000000, 0x008484, 0xFFDE00, 0xFFFFFF]);
    paletteColors[0x58] = PaletteColorsRow([0xFFFFFF, 0xA5A5A5, 0x525252, 0x000000], [0xFFFFFF, 0xA5A5A5, 0x525252, 0x000000], [0xFFFFFF, 0xA5A5A5, 0x525252, 0x000000]);
    paletteColors[0x6F] = PaletteColorsRow([0xFFFFFF, 0xFFCE00, 0x9C6300, 0x000000], [0xFFFFFF, 0xFFCE00, 0x9C6300, 0x000000], [0xFFFFFF, 0xFFCE00, 0x9C6300, 0x000000]);
    paletteColors[0x8C] = PaletteColorsRow([0xFFFFFF, 0xADAD84, 0x42737B, 0x000000], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000], [0xFFFFFF, 0xADAD84, 0x42737B, 0x000000]);
    paletteColors[0x61] = PaletteColorsRow([0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0xD3] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000]);
    paletteColors[0x14] = PaletteColorsRow([0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0xAA] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000]);
    paletteColors[0x3C] = PaletteColorsRow([0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x9C] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000]);
    paletteColors[0xB3] = PaletteColorsRow([0xFFFFFF, 0xADAD84, 0x42737B, 0x000000], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000]);
    paletteColors[0x34] = PaletteColorsRow([0xFFFFFF, 0x7BFF00, 0xB57300, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x66] = PaletteColorsRow([0xFFFFFF, 0x7BFF00, 0xB57300, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0xF4] = PaletteColorsRow([0xFFFFFF, 0x7BFF00, 0xB57300, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x3D] = PaletteColorsRow([0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x6A] = PaletteColorsRow([0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x19] = PaletteColorsRow([0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x1D] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000]);
    paletteColors[0x46] = PaletteColorsRow([0xB5B5FF, 0xFFFF94, 0xAD5A42, 0x000000], [0x000000, 0xFFFFFF, 0xFF8484, 0x943A3A], [0x000000, 0xFFFFFF, 0xFF8484, 0x943A3A]);
    paletteColors[0x0D] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000]);
    paletteColors[0xBF] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x4B] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x90] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x9A] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0xBD] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x28] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x97] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x39] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x43] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0xA5] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x00] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x3F] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0xC6] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x18] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x66] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x95] = PaletteColorsRow([0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0xB3] = PaletteColorsRow([0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0x52FF00, 0xFF4200, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x3E] = PaletteColorsRow([0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0xE0] = PaletteColorsRow([0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFF9C00, 0xFF0000, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0xF2] = PaletteColorsRow([0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x69] = PaletteColorsRow([0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x0D] = PaletteColorsRow([0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0xFFFF00, 0xFF0000, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x59] = PaletteColorsRow([0xFFFFFF, 0xADAD84, 0x42737B, 0x000000], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0xC6] = PaletteColorsRow([0xFFFFFF, 0xADAD84, 0x42737B, 0x000000], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0xA8] = PaletteColorsRow([0xFFFF9C, 0x94B5FF, 0x639473, 0x003A3A], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x86] = PaletteColorsRow([0xFFFF9C, 0x94B5FF, 0x639473, 0x003A3A], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0xD1] = PaletteColorsRow([0x6BFF00, 0xFFFFFF, 0xFF524A, 0x000000], [0xFFFFFF, 0xFFFFFF, 0x63A5FF, 0x0000FF], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0xF0] = PaletteColorsRow([0x6BFF00, 0xFFFFFF, 0xFF524A, 0x000000], [0xFFFFFF, 0xFFFFFF, 0x63A5FF, 0x0000FF], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0xCE] = PaletteColorsRow([0x6BFF00, 0xFFFFFF, 0xFF524A, 0x000000], [0xFFFFFF, 0xFFFFFF, 0x63A5FF, 0x0000FF], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0xBF] = PaletteColorsRow([0x6BFF00, 0xFFFFFF, 0xFF524A, 0x000000], [0xFFFFFF, 0xFFFFFF, 0x63A5FF, 0x0000FF], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x36] = PaletteColorsRow([0x52DE00, 0xFF8400, 0xFFFF00, 0xFFFFFF], [0xFFFFFF, 0xFFFFFF, 0x63A5FF, 0x0000FF], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000]);
    paletteColors[0x5C] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000], [0x0000FF, 0xFFFFFF, 0xFFFF7B, 0x0084FF]);
    paletteColors[0x49] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000], [0x0000FF, 0xFFFFFF, 0xFFFF7B, 0x0084FF]);
    paletteColors[0xB3] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000], [0x0000FF, 0xFFFFFF, 0xFFFF7B, 0x0084FF]);
    paletteColors[0x27] = PaletteColorsRow([0xA59CFF, 0xFFFF00, 0x006300, 0x000000], [0xFF6352, 0xD60000, 0x630000, 0x000000], [0x0000FF, 0xFFFFFF, 0xFFFF7B, 0x0084FF]);
    paletteColors[0xC9] = PaletteColorsRow([0xFFFFCE, 0x63EFEF, 0x9C8431, 0x5A5A5A], [0xFFFFFF, 0xFF7300, 0x944200, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x4E] = PaletteColorsRow([0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFFFF7B, 0x0084FF, 0xFF0000]);
    paletteColors[0x6B] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x18] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x6A] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFC542, 0xFFD600, 0x943A00, 0x4A0000], [0xFFFFFF, 0x5ABDFF, 0xFF0000, 0x0000FF]);
    paletteColors[0x9D] = PaletteColorsRow([0xFFFFFF, 0x8C8CDE, 0x52528C, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000]);
    paletteColors[0x17] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x8B] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x27] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x61] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x10] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0xF6] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x68] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x29] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x52] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x01] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x5D] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x6D] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0x70] = PaletteColorsRow([0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x00FF00, 0x318400, 0x004A00], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0xF7] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0xA2] = PaletteColorsRow([0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0x46] = PaletteColorsRow([0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000], [0xFFFF00, 0xFF0000, 0x630000, 0x000000], [0xFFFFFF, 0x7BFF31, 0x008400, 0x000000]);
    paletteColors[0xD3] = PaletteColorsRow([0xFFFFFF, 0xADAD84, 0x42737B, 0x000000], [0xFFFFFF, 0xFFAD63, 0x843100, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);
    paletteColors[0xF4] = PaletteColorsRow([0xFFFFFF, 0x7BFF31, 0x0063C5, 0x000000], [0xFFFFFF, 0xFF8484, 0x943A3A, 0x000000], [0xFFFFFF, 0x63A5FF, 0x0000FF, 0x000000]);

    // Set all unknown colours to default.
    /*for(int i = 0; i < list.length; i++) {
      if(list[i] == null) {
        list[i] = defaultPalette;
      }
    }*/

    return paletteColors;
  }
}