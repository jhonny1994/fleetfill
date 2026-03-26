import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MoneySummaryCard renders labels and emphasis', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MoneySummaryCard(
            title: 'Booking pricing',
            lines: [
              MoneySummaryLine(label: 'Base', amount: '100 DZD'),
              MoneySummaryLine(
                label: 'Total',
                amount: '150 DZD',
                emphasis: true,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Booking pricing'), findsOneWidget);
    expect(find.text('Base'), findsOneWidget);
    expect(find.text('150 DZD'), findsOneWidget);
  });
}
