

import 'dart:math';

class BigIntUtils {

  static BigInt toBigInt(dynamic number) {
    assert(number is num || number is int || number is double);
    return BigInt.from(number);
  }

  static int toInt(BigInt number) {
    return number.toInt();
  }

  static num toNum(BigInt number, [int decimal = 18]) {
    return number / BigInt.from(10).pow(decimal);
  }

  static BigInt toDecimalPow(num number, int decimal) {
    final BigInt _multiplier = BigInt.from(10).pow(decimal - 1);
    final num _baseValue = number * 10;
    return BigInt.from(_baseValue) * _multiplier;
  }

  static String bigIntToString(BigInt number) {
    return number.toRadixString(16);
  }

  static BigInt multiply(BigInt number, BigInt multiplier) {
    return number * multiplier;
  }

  static BigInt remainder(BigInt number, BigInt remainder) {
    return number.remainder(remainder);
  }

  static BigInt pow(BigInt number, int power) {
    return number.pow(power);
  }

}