import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_check_out.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.cart),
        centerTitle: true,
      ),
      body: Container(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            CartItem(),
            Spacer(),
            CartCheckOut(),
          ],
        ),
      ),
    );
  }
}
