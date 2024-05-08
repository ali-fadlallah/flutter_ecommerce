import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart' as ViewModel;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/utils/assets/assets_manager.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';

class ProductDetails extends StatelessWidget {
  ProductEntity productEntity;

  ProductDetails({Key? key, required this.productEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(StringsManager.productDetails),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.h,
              width: 398.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.w,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.30),
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ImageSlideshow(
                autoPlayInterval: 3000,
                isLoop: true,
                indicatorBackgroundColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Colors.white,
                onPageChanged: (value) {},
                children: productEntity.images!
                    .map((url) => CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(AssetsManager.imgPlaceHolder),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    '${productEntity.title}\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Spacer(),
                Text(
                  productEntity.priceAfterDiscount != null
                      ? '${StringsManager.EGP} ${productEntity.priceAfterDiscount} '
                      : '${StringsManager.EGP} ${productEntity.price}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.w,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    '${productEntity.sold} ${StringsManager.sold}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(AssetsManager.iconStar),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text('${productEntity.ratingsAverage} (${productEntity.ratingsQuantity})'),
                  ],
                ),
                Container(
                  margin: REdgeInsets.all(8),
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              CartCubit.get(context).decrease(theCurrentNumber: CartCubit.get(context).current);
                            },
                            icon: SvgPicture.asset(AssetsManager.iconSubStractCartItem),
                          ),
                          Text(
                            '${CartCubit.get(context).current}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          IconButton(
                            onPressed: () {
                              CartCubit.get(context).increase(theCurrentNumber: CartCubit.get(context).current);
                            },
                            icon: SvgPicture.asset(AssetsManager.iconAddCartItem),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '${StringsManager.description}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ReadMoreText(
                  '${productEntity.description}',
                  trimMode: TrimMode.Line,
                  trimLines: 5,
                  colorClickableText: Colors.red,
                  trimCollapsedText: ' ${StringsManager.showMore}',
                  trimExpandedText: ' ${StringsManager.showLess}',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      StringsManager.totalPrice,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: 20.sp,
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                          ),
                    ),
                    Text(
                      productEntity.priceAfterDiscount != null
                          ? '${StringsManager.EGP} ${productEntity.priceAfterDiscount} '
                          : '${StringsManager.EGP} ${productEntity.price}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(
                  width: 33.w,
                ),
                Expanded(
                  flex: 2,
                  child: BlocBuilder<ViewModel.HomeViewModel, ViewModel.HomeInitiateState>(
                    builder: (context, state) {
                      if (state is ViewModel.CartOnLoading && state.productId == productEntity.id) {
                        return SizedBox(
                          width: 30.w,
                          height: 48.h,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          ViewModel.HomeViewModel.get(context).addToCart(productId: productEntity.id ?? '');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_shopping_cart_sharp, color: Colors.white),
                            SizedBox(
                              width: 24.w,
                              height: 48.h,
                            ),
                            Text(
                              StringsManager.addToCart,
                              style: Theme.of(context).textTheme.labelLarge,
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
      ),
    );
  }
}
