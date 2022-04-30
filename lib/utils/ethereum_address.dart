import 'package:web3dart/credentials.dart' show EthereumAddress;

class EthereumAddressUtils {

  static bool isAddress(String address) {
    return true;
  }

  static String shortenAddress(String address) {
    assert(isAddress(address));
    return address.substring(0, 4) + '...' + address.substring(38);
  }

  static EthereumAddress buildAddress(String address) {
    assert(isAddress(address));
    return EthereumAddress.fromHex(address);
  }
}