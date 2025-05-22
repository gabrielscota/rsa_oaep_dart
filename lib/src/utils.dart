import 'dart:typed_data';

BigInt os2ip(Uint8List x) {
  return BigInt.parse(x.map((e) => e.toRadixString(16).padLeft(2, '0')).join(), radix: 16);
}

Uint8List i2osp(BigInt x, int xLen) {
  final bytes = x.toRadixString(16).padLeft(xLen * 2, '0');
  return Uint8List.fromList(List.generate(xLen, (i) => int.parse(bytes.substring(i * 2, i * 2 + 2), radix: 16)));
}
