import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:cyberlife/main.dart';
import 'package:cyberlife/screens/dashboard_page.dart';
import 'package:cyberlife/state/app_state.dart';

void main() {
  testWidgets('CyberLife abre a tela inicial', (WidgetTester tester) async {
    final appState = AppState();
    addTearDown(appState.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: const CyberLifeApp(),
      ),
    );

    expect(find.byType(DashboardPage), findsOneWidget);
  });
}