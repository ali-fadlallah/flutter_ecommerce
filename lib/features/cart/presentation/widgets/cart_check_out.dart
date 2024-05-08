import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCheckOut extends StatelessWidget {
  final int? totalAmount;

  const CartCheckOut({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                StringsManager.totalPrice,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 20.sp,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                    ),
              ),
              Text(
                '${StringsManager.EGP} ${totalAmount ?? 0}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringsManager.checkOut,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  width: 20.w,
                ),
                const Icon(Icons.arrow_forward_outlined, color: Colors.white),
              ],
            ),
          ),
        )
      ],
    );
  }
}
