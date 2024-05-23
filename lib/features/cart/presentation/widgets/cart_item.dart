import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../home/presentation/manager/home_viewmodel.dart';
import '../../domain/entities/CartItemEntity.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity? cartItemEntity;
  int counter = 0;

  CartItem({Key? key, required this.cartItemEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.w,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.30),
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 113.w,
            height: 120.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.30),
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItemEntity?.product?.imageCover ?? '',
              fit: BoxFit.fill,
              width: 120.w,
              height: 113.h,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItemEntity?.product?.title ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${AppLocalizations.of(context)!.egp} ${cartItemEntity?.price?.toInt() ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is DeleteItemLoadingState && state.productID == cartItemEntity?.product?.id) {
                      return Container(
                        width: 40.w,
                        height: 40.h,
                        margin: REdgeInsets.all(8),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: () {
                        CartCubit.get(context).deleteItemCart(productId: cartItemEntity?.product?.id ?? '');
                        context.read<HomeViewModel>().getCartCount();
                      },
                      icon: SvgPicture.asset(
                        AssetsManager.iconDeleteCartItem,
                        width: 24.w,
                        height: 24.w,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is UpdateCountScreenLoadingState && state.productID == cartItemEntity?.product?.id) {
                      return Container(
                        width: 40.w,
                        height: 40.h,
                        margin: REdgeInsets.all(8),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Container(
                      margin: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              counter = cartItemEntity?.count?.toInt() ?? 0;
                              counter--;
                              if (counter <= 0) {
                                CartCubit.get(context).deleteItemCart(productId: cartItemEntity?.product?.id ?? '');
                                context.read<HomeViewModel>().getCartCount();
                              } else {
                                CartCubit.get(context).updateCart(productId: cartItemEntity?.product?.id ?? '', count: counter.toString());
                              }
                            },
                            icon: SvgPicture.asset(AssetsManager.iconSubStractCartItem),
                          ),
                          Text(
                            '${cartItemEntity?.count?.toInt() ?? 0}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              counter = cartItemEntity?.count?.toInt() ?? 0;
                              counter++;
                              CartCubit.get(context).updateCart(productId: cartItemEntity?.product?.id ?? '', count: counter.toString());
                            },
                            icon: SvgPicture.asset(AssetsManager.iconAddCartItem),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
