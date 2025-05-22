import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Uint8List mgf1(Uint8List seed, int length, Digest hash) {
  final hLen = hash.digestSize;
  final count = (length / hLen).ceil();
  final output = BytesBuilder();

  for (var i = 0; i < count; i++) {
    final c = Uint8List(4)
      ..[0] = (i >> 24) & 0xFF
      ..[1] = (i >> 16) & 0xFF
      ..[2] = (i >> 8) & 0xFF
      ..[3] = i & 0xFF;

    final data = Uint8List.fromList(seed + c);
    output.add(hash.process(data));
  }

  final outputBytes = output.toBytes();
  return Uint8List.fromList(outputBytes.sublist(0, length));
}
