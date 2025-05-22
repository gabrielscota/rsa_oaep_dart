import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import 'mgf1.dart';
import 'utils.dart';

class RSAOAEP {
  final Digest hash;
  final RSAPublicKey publicKey;
  final RSAPrivateKey? privateKey;
  final Uint8List label;

  RSAOAEP({required this.hash, required this.publicKey, this.privateKey, Uint8List? label})
      : label = label ?? Uint8List(0);

  Uint8List encrypt(Uint8List message) {
    final k = (publicKey.modulus!.bitLength + 7) ~/ 8;
    final hLen = hash.digestSize;

    if (message.length > k - 2 * hLen - 2) {
      throw ArgumentError('Message too long');
    }

    final lHash = _digest(label);
    final ps = Uint8List(k - message.length - 2 * hLen - 2);
    final db = Uint8List.fromList([...lHash, ...ps, 0x01, ...message]);

    final seed = _randomBytes(hLen);
    final dbMask = mgf1(seed, k - hLen - 1, hash);
    final maskedDB = _xor(db, dbMask);

    final seedMask = mgf1(maskedDB, hLen, hash);
    final maskedSeed = _xor(seed, seedMask);

    final em = Uint8List.fromList([0x00, ...maskedSeed, ...maskedDB]);

    final m = os2ip(em);
    final c = m.modPow(publicKey.exponent!, publicKey.modulus!);
    return i2osp(c, k);
  }

  Uint8List decrypt(Uint8List ciphertext) {
    if (privateKey == null) {
      throw StateError('Private key required for decryption');
    }

    final k = (privateKey!.modulus!.bitLength + 7) ~/ 8;
    final hLen = hash.digestSize;

    if (ciphertext.length != k) {
      throw ArgumentError('Decryption error');
    }

    final c = os2ip(ciphertext);
    final m = c.modPow(privateKey!.exponent!, privateKey!.modulus!);
    final em = i2osp(m, k);

    if (em[0] != 0x00) {
      throw ArgumentError('Decryption error');
    }

    final maskedSeed = em.sublist(1, hLen + 1);
    final maskedDB = em.sublist(hLen + 1);

    final seedMask = mgf1(maskedDB, hLen, hash);
    final seed = _xor(maskedSeed, seedMask);

    final dbMask = mgf1(seed, k - hLen - 1, hash);
    final db = _xor(maskedDB, dbMask);

    final lHash = _digest(label);
    final lHashPrime = db.sublist(0, hLen);

    if (!_equal(lHash, lHashPrime)) {
      throw ArgumentError('Decryption error');
    }

    int index = hLen;
    while (index < db.length && db[index] == 0x00) {
      index++;
    }

    if (index == db.length || db[index] != 0x01) {
      throw ArgumentError('Decryption error');
    }

    return db.sublist(index + 1);
  }

  Uint8List _digest(Uint8List data) {
    hash.reset();
    return hash.process(data);
  }

  Uint8List _randomBytes(int length) {
    final rnd = Random.secure();
    return Uint8List.fromList(List.generate(length, (_) => rnd.nextInt(256)));
  }

  Uint8List _xor(Uint8List a, Uint8List b) {
    return Uint8List.fromList(List.generate(a.length, (i) => a[i] ^ b[i]));
  }

  bool _equal(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
