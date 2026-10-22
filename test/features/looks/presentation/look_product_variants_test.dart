import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_item_card.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_variants.dart';

Widget _buildTestApp(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  const testColors = [
    ProductColorEntity(id: 1, name: 'Black', hex: '#000000'),
    ProductColorEntity(id: 2, name: 'White', hex: '#FFFFFF'),
  ];

  const testProduct = ProductEntity(
    id: '101',
    name: 'Oversized Trench Coat',
    brand: 'MANGO',
    price: 4999.0,
    imageUrl: 'https://example.com/coat.jpg',
    category: 'Clothing',
    subcategory: 'Coats',
    colors: testColors,
  );

  testWidgets('LookProductColorSwatches triggers onColorSelected on tap',
      (tester) async {
    int? selectedColorId;

    await tester.pumpWidget(
      _buildTestApp(
        LookProductColorSwatches(
          colors: testColors,
          selectedColorId: 1,
          onColorSelected: (id) => selectedColorId = id,
        ),
      ),
    );

    expect(find.byType(GestureDetector), findsNWidgets(2));
    await tester.tap(find.byType(GestureDetector).last);
    expect(selectedColorId, equals(2));
  });

  testWidgets('LookProductSizesRow triggers onSizeSelected on tap',
      (tester) async {
    String? selectedSize;

    await tester.pumpWidget(
      _buildTestApp(
        LookProductSizesRow(
          category: 'Clothing',
          subcategory: 'Coats',
          selectedSize: 'M',
          onSizeSelected: (size) => selectedSize = size,
        ),
      ),
    );

    expect(find.text('L'), findsOneWidget);
    await tester.tap(find.text('L'));
    expect(selectedSize, equals('L'));
  });

  testWidgets(
      'LookProductItemCard tracks selected color and size and delivers them to onAddToBag',
      (tester) async {
    int? addedColorId;
    String? addedSize;

    await tester.pumpWidget(
      _buildTestApp(
        SingleChildScrollView(
          child: LookProductItemCard(
            product: testProduct,
            onViewProduct: () {},
            onAddToBag: ({colorId, size}) {
              addedColorId = colorId;
              addedSize = size;
            },
          ),
        ),
      ),
    );

    // Initial defaults: first color (1) and 'M'
    // Tap on size 'S'
    await tester.tap(find.text('S'));
    await tester.pump();

    // Tap on second color swatch
    final swatchFinder = find.descendant(
      of: find.byType(LookProductColorSwatches),
      matching: find.byType(GestureDetector),
    );
    await tester.tap(swatchFinder.last);
    await tester.pump();

    // Tap ADD TO BAG
    await tester.tap(find.text('ADD TO BAG'));
    await tester.pump();

    expect(addedColorId, equals(2));
    expect(addedSize, equals('S'));
  });
}
