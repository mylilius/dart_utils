import 'package:hex/hex.dart' show HEX;
import 'package:pointycastle/digests/keccak.dart' show KeccakDigest;
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/argon2.dart' show Argon2BytesGenerator;
import 'dart:math' show Random;
import 'dart:typed_data';


class Hash {

  final Argon2BytesGenerator _generator = Argon2BytesGenerator();
  final KeccakDigest _keccakDigest = KeccakDigest(256);
  
  bool comparePassword(Uint8List _salt, String _password, String _hashedPassword) {
    return hashPassword(_salt, _password) == _hashedPassword;
  }

  String hashPassword(Uint8List _salt, String _password) {
    try {
      final Argon2Parameters _params = _buildParameters(_salt);
      _generator.init(_params);
      final Uint8List _passwordKey = _generator.process(Uint8List.fromList(_password.codeUnits));
      final Uint8List _hashedBytes = _generateHash(_passwordKey);
      return HEX.encode(_keccakDigest.process(_hashedBytes));
    } catch (err) {
      throw Exception(err);
      return "";
    }
  }

  Uint8List generateSalt() {
    return Uint8List.fromList(_generateSalt().codeUnits);
  }

  Uint8List _generateHash(Uint8List _key) {
    Uint8List _result = Uint8List(32);
    _generator.deriveKey(_key, 0, _result, 0);
    return _result;
  }

  // Uint8List _passwordConverter(Argon2Parameters _params, String _password) {
  //   return _params.secret.convert(_password);
  // }

  Argon2Parameters _buildParameters(Uint8List _salt) {
    return Argon2Parameters(
        Argon2Parameters.ARGON2_i,
        _salt,
        version: Argon2Parameters.ARGON2_VERSION_13,
        iterations: 1,
        memoryPowerOf2: 8,
        desiredKeyLength: 32
    );
  }

  String _generateSalt() {
    final StringBuffer _buffer = StringBuffer();
    final int dateComponentRandom = _generateDateComponent(true);
    final int dateComponentToday = _generateDateComponent();
    final int randomNumber = generateRandomNumber();
    _buffer.writeAll([dateComponentRandom.toString(), dateComponentToday.toString(), randomNumber.toString()]);
    return _buffer.toString();

  }

  int _generateDateComponent([bool isRandom = false]) {
    if (isRandom) {
      return DateTime(generateRandomNumber(2100) + 1900, generateRandomNumber(12) + 1, generateRandomNumber(28) + 1).millisecond;
    }
    return DateTime.now().millisecondsSinceEpoch;
  }

  int generateRandomNumber([int max = 100000000]) {
    return Random.secure().nextInt(max);
  }

}