import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/home/domain/entities/products_entity/ProductEntity.dart';

class ProductEntityItem extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductEntityItem({Key? key, required this.productEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AssetsManager.imgWishList),
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
                          ? '${StringsManager.EGP} ${productEntity.priceAfterDiscount} '
                          : '${StringsManager.EGP} ${productEntity.price}',
                    ),
                    Text(
                      productEntity.priceAfterDiscount != null ? '${productEntity.price} ${StringsManager.EGP}' : '',
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
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(AssetsManager.imgAddToCart),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
