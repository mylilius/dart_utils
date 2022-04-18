import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class Encryption {
  late final Encrypter _encrypter;
  final Key key = Key.fromLength(32);
  late IV iv;

  Encryption(String v) {
    iv = IV.fromUtf8(v);

    _encrypter = Encrypter(AES(key));
  }

  String encrypt(String value) {
    final Encrypted _encrypted = _encrypter.encrypt(value, iv: iv);
    return _encrypted.base64;
  }

  String decrypt(String base64) {
    return _encrypter.decrypt64(base64, iv: iv);
  }
}