import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/toast/show_toast.dart';

class WishListItem extends StatelessWidget {
  final ProductEntity? productEntity;

  const WishListItem({Key? key, required this.productEntity}) : super(key: key);

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
              imageUrl: productEntity?.imageCover ?? '',
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
                  productEntity?.title ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      productEntity?.priceAfterDiscount != null
                          ? '${StringsManager.EGP} ${productEntity?.priceAfterDiscount} '
                          : '${StringsManager.EGP} ${productEntity?.price}',
                    ),
                    Text(
                      productEntity?.priceAfterDiscount != null ? '${productEntity?.price} ${StringsManager.EGP}' : '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: REdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AssetsManager.iconWishList,
                  width: 50.w,
                  height: 50.w,
                ),
                BlocConsumer<HomeViewModel, HomeInitiateState>(
                  listener: (context, state) {
                    if (state is CartOnSuccess && state.productId == productEntity?.id) {
                      ShowToast.showSuccess(state.cartResponseEntity?.message ?? '');
                    }
                    if (state is CartOnError) {
                      ShowToast.showError(state.errorMsg ?? '');
                    }
                  },
                  builder: (context, state) {
                    if (state is CartOnLoading && state.productId == productEntity?.id) {
                      return SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        HomeViewModel.get(context).addToCart(productId: productEntity?.id ?? '');
                      },
                      child: Container(
                        padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          StringsManager.addToCart,
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
