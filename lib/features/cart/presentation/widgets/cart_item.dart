import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.w,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.60),
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.w,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.60),
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Image.asset(
              AssetsManager.imgRoute,
              fit: BoxFit.fill,
              width: 120.w,
              height: 120.h,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Nike Air Jordon'),
              SizedBox(
                height: 30.h,
              ),
              Text('Nike Air Jordon'),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AssetsManager.iconDeleteCartItem),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AssetsManager.iconSubStractCartItem),
                    ),
                    Text(
                      '1',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AssetsManager.iconAddCartItem),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
