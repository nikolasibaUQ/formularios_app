import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/shared/utils/utils.dart';

void main() {
  test('test for validator email', () {
    final isEmail = Utils.validateEmail('nikolasiba');

    expect(isEmail, false);

    final isEmail2 = Utils.validateEmail('nikolasiba@g.com');

    expect(isEmail2, true);
  });

  test('test for validator password', () {
    final isPassword = Utils.validatePassword('nikolasiba');

    expect(isPassword, false);

    final isPassword2 = Utils.validatePassword('Nikolas1@');

    expect(isPassword2, true);
  });

  test('test for validator date', () {
    final isDate = Utils.validateDate('nikolasiba');

    expect(isDate, false);

    final isDate2 = Utils.validateDate('12-12-2021');

    expect(isDate2, true);

    final isDate3 = Utils.validateDate('12/12/2021');

    expect(isDate3, true);
  });

  test('test for validator no numbers', () {
    final isNoNumbers = Utils.validateNoNumbers('nikolasiba');

    expect(isNoNumbers, true);

    final isNoNumbers2 = Utils.validateNoNumbers('nikolasiba1');

    expect(isNoNumbers2, false);

    final isNoNumbers3 = Utils.validateNoNumbers('nikolasiba@');

    expect(isNoNumbers3, false);

    final isNoNumbers4 = Utils.validateNoNumbers('123123123');

    expect(isNoNumbers4, false);
  });
}
