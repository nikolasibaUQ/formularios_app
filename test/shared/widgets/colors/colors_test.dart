// ignore_for_file: deprecated_member_use

import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/shared/colors/hex_color.dart';

void main() {
  group('HexColor', () {
    test(
        'Given a upper string without #, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = 'AABBCC';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFFAABBCC));
    });

    test(
        'Given a upper string with #, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = '#AABBCC';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFFAABBCC));
    });

    test(
        'Given a lower string without #, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = '#aabbcc';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFFAABBCC));
    });

    test(
        'Given a lower string with #, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = '#aabbcc';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFFAABBCC));
    });

    test(
        'Given a string with more than 6 characters, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = '#a1b2cca3';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFFa1b2cc));
    });

    test(
        'Given a string with less than 6 characters, when it is converted to hex, then it must return a integer value representing the color obtained from the given hexadecimal color code',
        () {
      //GIVEN
      String hexString = '#123';
      //WHEN
      final result = HexColor(hexString);
      //THEN
      expect(result.value, equals(0xFF123000));
    });
  });
}
