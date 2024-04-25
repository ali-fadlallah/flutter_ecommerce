import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAds extends StatelessWidget {
  const HomeAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: AssetsManager.imgAds.length,
      itemBuilder: (context, index, realIndex) {
        return Image.asset(
          AssetsManager.imgAds[index],
          height: 200.h,
          width: 396.w,
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        // autoPlayInterval: const Duration(seconds: 1),
        viewportFraction: 1,
        enlargeFactor: 0.5,
        enlargeCenterPage: true,
      ),
    );
  }
}
