import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/shared/widgets/custom_primary_button.dart';

void main() {
  group('CustomPrimaryButton', () {
    testWidgets(
        'Given a CustomPrimaryButton, when it is build, it must find a FilledButton and it is disabled',
        (widgetTester) async {
      // GIVEN
      var testWidget = MaterialApp(
        home: CustomPrimaryButton(
            isDisabled: true, text: "MyCustomButton", onPressed: () {}),
      );

      // WHEN
      await widgetTester.pumpWidget(testWidget);

      // THEN
      expect(find.byType(FilledButton), findsOneWidget);
    });
  });
}
