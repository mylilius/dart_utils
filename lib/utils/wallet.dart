import 'dart:math';
import 'dart:typed_data';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart' show EthPrivateKey, Wallet;

class WalletUtils {

  static const String CHILD_INDEX_PATH = "m/44'/60'/0'/0/";

  /// TODO - Implement Private Key from Mnemonic - Internal
  String? _privateKeyFromMnemonic(String _mnemonic, { int childIndex = 0 }) {
    try {
      /// Turn Mnemonic into Bytes
      final Uint8List _seed = bip39.mnemonicToSeed(_mnemonic);
      /// Turn Mnemonic as Bytes into Root
      final bip32.BIP32 _root = bip32.BIP32.fromSeed(_seed);
      /// Derive Path from Root
      final bip32.BIP32 _path = _root.derivePath('$CHILD_INDEX_PATH$childIndex');
      if (_path.privateKey == null) {
        throw Exception("Error Deriving Private Key");
      }
      final String _privateKey = HEX.encode(_path.privateKey!);
      return _privateKey;

    } catch (err) {
      rethrow;
    }

  }

  EthPrivateKey _buildPrivateKeyFromHex(String _privateKey) {
    return EthPrivateKey.fromHex(_privateKey);
  }

  String generateWallet(String _mnemonic, String _password) {
    try {
      final String? _privateKeyHex = _privateKeyFromMnemonic(_mnemonic);
      if (_privateKeyHex == null) {
        throw Exception('Private Key Cannot Be Null');
      }

      final EthPrivateKey _pk = _buildPrivateKeyFromHex(_privateKeyHex);
      final Wallet _wallet = Wallet.createNew(_pk, _password, Random.secure());
      return _wallet.toJson();
    } catch (err) {
      rethrow;
    }
  }

  Wallet buildWallet(String _encryptedJsonWallet, String _password) {
    try {
      final Wallet _wallet = Wallet.fromJson(_encryptedJsonWallet, _password);
      return _wallet;
    } catch (err) {
      throw Exception(err);
    }
  }

}