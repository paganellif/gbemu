import 'package:gbemu/emulator/graphics/palette.dart';
import 'package:gbemu/emulator/memory/memory_registers.dart';
import '../cpu/cpu.dart';

class GBPalette implements Palette {
  CPU cpu;
  int register = 0;
  @override
  List<int> colors;

  GBPalette(this.cpu, this.colors, this.register) {
    if(register != MemoryRegisters.BGP &&
        register != MemoryRegisters.OBP0 &&
        register != MemoryRegisters.OBP1) {
      throw Exception("Register must be one of R.R_BGP, R.R_OBP0, or R.R_OBP1.");
    }

    if(colors.length < 4) {
      throw Exception("Colors must be of length 4.");
    }
  }

  @override
  int getColor(int number) {
    return colors[(cpu.mmu.readRegisterByte(register) >> (number * 2)) & 0x3];
  }
}