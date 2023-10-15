import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:europharm_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test Warehouse Page', (WidgetTester tester) async {
    app.main();

    // Здесь вы можете использовать tester для выполнения действий в вашем приложении,
    // таких как нажатия на кнопки, ввод текста и т.д., и проверки результатов.

    // Пример:
    await tester.pumpAndSettle(); // Дождитесь загрузки приложения

    // Нажмите на кнопку или выполните другие действия, чтобы попасть на WarehousePage

    // Проверьте, что вы находитесь на WarehousePage
    expect(find.text('WarehousePage'), findsOneWidget);

    // Выполните другие проверки ваших виджетов на странице

    // Пример: Проверьте, что элемент с определенным ключом существует
    expect(find.byKey(Key('myButton')), findsOneWidget);

    // Выполните действия, такие как нажатие на кнопку
    await tester.tap(find.byKey(Key('myButton')));

        // Проверьте результаты действия
        expect(find.text('Button Pressed'), findsOneWidget);
  });
}
