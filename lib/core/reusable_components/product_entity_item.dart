import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/toast/show_toast.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/home/domain/entities/products_entity/ProductEntity.dart';
import '../di/di.dart';

class ProductEntityItem extends StatefulWidget {
  final ProductEntity productEntity;
  const ProductEntityItem({Key? key, required this.productEntity}) : super(key: key);

  @override
  State<ProductEntityItem> createState() => _ProductEntityItemState();
}

class _ProductEntityItemState extends State<ProductEntityItem> {
  HomeViewModel viewModel = getIt();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  imageUrl: widget.productEntity.imageCover ?? AssetsManager.imgPlaceHolder,
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
                  '${widget.productEntity.title}\n\n',
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
                      widget.productEntity.priceAfterDiscount != null
                          ? '${StringsManager.EGP} ${widget.productEntity.priceAfterDiscount} '
                          : '${StringsManager.EGP} ${widget.productEntity.price}',
                    ),
                    Text(
                      widget.productEntity.priceAfterDiscount != null ? '${widget.productEntity.price} ${StringsManager.EGP}' : '',
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
                      initialRating: widget.productEntity.ratingsAverage?.toDouble() ?? 0.0,
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
                      bloc: viewModel,
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is CartOnSuccess) {
                          ShowToast.showSuccess(state.cartResponseEntity?.message ?? '');
                        }
                        if (state is CartOnError) {
                          ShowToast.showError(state.errorMsg ?? '');
                        }
                      },
                      builder: (context, state) {
                        if (state is CartOnLoading) {
                          return SizedBox(
                            width: 30,
                            height: 30,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            viewModel.addToCart(productId: widget.productEntity.id ?? '');
                            viewModel.numOfItem = 100;
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
    );
  }
}
