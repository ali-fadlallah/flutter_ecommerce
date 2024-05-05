import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCheckOut extends StatelessWidget {
  const CartCheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  'Total Price',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '1000 EGP',
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
                    'CheckOut',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(Icons.arrow_forward_outlined, color: Colors.white),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
