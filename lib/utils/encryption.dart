import 'package:encrypt/encrypt.dart';

class Encryption {
  late final Encrypter _encrypter;
  final Key key = Key.fromLength(32);
  final IV iv = IV.fromLength(16);

  Encryption() {
    _encrypter = Encrypter(AES(key));
  }

  String encrypt(String value) {
    final Encrypted _encrypted = _encrypter.encrypt(value, iv: iv);
    return _encrypted.base64;
  }

  String decrypt(String base64) {
    return _encrypter.decrypt64(base64, iv: IV.fromLength(15));
  }
}