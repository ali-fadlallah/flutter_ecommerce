import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/config/routes/page_routes_name.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_cubit.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/home/domain/entities/products_entity/ProductEntity.dart';
import '../utils/toast/show_toast.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity productEntity;

  ProductItem({Key? key, required this.productEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageRoutesNames.productDetailsRouteName, arguments: productEntity);
      },
      child: Container(
        width: 191.w,
        height: 237.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13.r),
                    topLeft: Radius.circular(13.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productEntity.imageCover ?? AssetsManager.imgPlaceHolder,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    width: 191.w,
                    height: 128.h,
                    fit: BoxFit.fill,
                  ),
                ),
                BlocConsumer<WishListCubit, WishListState>(
                  listener: (context, state) {
                    if (state is WishListOnSuccess && state.productId == productEntity.id) {
                      ShowToast.showSuccess(state.wishListEntity?.message ?? '');
                    }
                    if (state is WishListOnError) {
                      ShowToast.showError(state.errorMsg ?? '');
                    }
                  },
                  builder: (context, state) {
                    if (state is WishListOnLoading && state.productId == productEntity.id) {
                      return SizedBox(width: 30.w, height: 30.h, child: const CircularProgressIndicator());
                    }
                    return InkWell(
                      onTap: () {
                        WishListCubit.get(context).addToWishList(productId: productEntity.id ?? '');
                      },
                      child: SvgPicture.asset(AssetsManager.imgWishList),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              padding: REdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productEntity.title}\n\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Text(
                        productEntity.priceAfterDiscount != null
                            ? '${AppLocalizations.of(context)!.egp} ${productEntity.priceAfterDiscount} '
                            : '${AppLocalizations.of(context)!.egp} ${productEntity.price}',
                      ),
                      Text(
                        productEntity.priceAfterDiscount != null ? '${productEntity.price} ${AppLocalizations.of(context)!.egp}' : '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: productEntity.ratingsAverage?.toDouble() ?? 0.0,
                        allowHalfRating: true,
                        minRating: 1,
                        ignoreGestures: true,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      BlocConsumer<HomeViewModel, HomeInitiateState>(
                        listener: (context, state) {
                          if (state is CartOnSuccess && state.productId == productEntity.id) {
                            ShowToast.showSuccess(state.cartResponseEntity?.message ?? '');
                          }
                          if (state is CartOnError) {
                            ShowToast.showError(state.errorMsg ?? '');
                          }
                        },
                        builder: (context, state) {
                          if (state is CartOnLoading && state.productId == productEntity.id) {
                            return SizedBox(
                              width: 30.w,
                              height: 30.h,
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              HomeViewModel.get(context).addToCart(productId: productEntity.id ?? '');
                            },
                            child: SvgPicture.asset(AssetsManager.imgAddToCart),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
