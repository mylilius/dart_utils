import 'dart:math';
import 'dart:typed_data';
import 'package:convert/convert.dart' show hex;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart' show EthereumAddress;

abstract class SkaleProofOfWorkUtils {

  static Uint8List getRandomBytes() {
    return _randomBytes(32);
  }

  static Uint8List _randomBytes(int length, { bool secure = false }) {
    assert(length > 0);
    final Random random = secure ? Random.secure() : Random();
    final Uint8List ret = Uint8List(length);
    for (int i = 0; i < length; i++) {
      ret[i] = random.nextInt(256);
    }
    return ret;
  }

  static BigInt getMaxNumber() {
    final BigInt base = BigInt.two;
    final BigInt power = base.pow(BigInt.from(256).toInt());
    final BigInt max = power - BigInt.one;
    return max;
  }

  static BigInt hashInt(int value) {
    final BigInt _bigIntHash = BigInt.parse(bytesToHex(keccak256(padUint8ListTo32(intToBuffer(value)))), radix: 16);
    return _bigIntHash;
  }

  static BigInt hashAddress(EthereumAddress address) {
    final Uint8List _dataAsList = keccak256(address.addressBytes);
    // print("Address Bytes");
    // print(address.addressBytes);
    // final String _dataAsString = base64.encode(_dataAsList);
    // final BigInt _bigIntHash = BigInt.parse(_dataAsString);
    final BigInt? _bigIntHash = BigInt.tryParse(bytesToHex(_dataAsList), radix: 16);
    return _bigIntHash!;

  }

  /// Converts a [int] into a hex [String]
  static String intToHex(int i) {
    return "0x${i.toRadixString(16)}";
  }

  /// Converts an [int] to a [Uint8List]
  static Uint8List intToBuffer(int i) {
    return Uint8List.fromList(hex.decode(padToEven(intToHex(i).substring(2))));
  }
  static String stripHexPrefix(String str) {
    return isHexPrefixed(str) ? str.substring(2) : str;
  }

  /// Pads a [String] to have an even length
  static String padToEven(String value) {
    var a = "${value}";

    if (a.length % 2 == 1) {
      a = "0${a}";
    }

    return a;
  }

  static bool isHexPrefixed(String str) {
    return str.startsWith('0x');
  }

  static String _bytesToHex(List<int> bytes,
      {bool include0x = false,
        int? forcePadLength,
        bool padToEvenLength = false}) {
    var encoded = hex.encode(bytes);

    if (forcePadLength != null) {
      assert(forcePadLength >= encoded.length);

      final padding = forcePadLength - encoded.length;
      encoded = ('0' * padding) + encoded;
    }

    if (padToEvenLength && encoded.length % 2 != 0) {
      encoded = '0$encoded';
    }

    return (include0x ? '0x' : '') + encoded;
  }

  static Uint8List padUint8ListTo32(Uint8List data) {
    // print("Length");
    // print(data.length);
    assert(data.length <= 32);
    if (data.length == 32) return data;

    // todo there must be a faster way to do this?
    return Uint8List(32)..setRange(32 - data.length, 32, data);
  }

  // static Future<Transaction> buildTx(EthereumAddress address)
}