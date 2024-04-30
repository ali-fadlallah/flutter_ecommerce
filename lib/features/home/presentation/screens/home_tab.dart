import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/row_section_widget.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home_ads/home_ads.dart';
import '../widgets/home_brands/home_brands.dart';
import '../widgets/home_categories/home_categories.dart';
import '../widgets/home_most_selling/home_most_selling_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: HomeAds(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        const SliverToBoxAdapter(child: RowSectionWidget(sectionName: StringsManager.categories)),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        SliverToBoxAdapter(
          child: HomeCategories(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        const SliverToBoxAdapter(child: RowSectionWidget(sectionName: StringsManager.brands)),
        const SliverToBoxAdapter(
          child: HomeBrands(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        const SliverToBoxAdapter(child: RowSectionWidget(sectionName: StringsManager.mostSelling)),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        const SliverToBoxAdapter(
          child: HomeMostSellingWidget(),
        )
      ],
    );
  }
}
