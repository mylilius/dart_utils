import 'package:bip39/bip39.dart' as bip39;


class Mnemonic {

  bool isValidSeedPhrase(String _mnemonic) {
    try {
      if (bip39.validateMnemonic(_mnemonic)) {
        return true;
      } else {
        throw Exception('Invalid');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  String generateMnemonic([int length = 24]) {
    try {
      return bip39.generateMnemonic(strength: _getStrength(length));
    } catch (err) {
      throw Exception(err);
    }
  }

  int _getStrength(int _length) {
    switch (_length) {
      case 12:
        return 128;
      case 15:
        return 160;
      case 18:
        return 192;
      case 21:
        return 224;
      default:
        return 256;
    }
  }
}