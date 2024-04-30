import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/categories/presentation/screens/categories_tab.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_view_model.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/screens/home_tab.dart';
import 'package:flutter_ecommerce_app/features/profile/presentation/screens/profile_tab.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/screens/wishlist_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> widgetsList = [HomeTab(), CategoriesTab(), WishListTab(), ProfileTab()];

  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setCurrentIndex(viewModel.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: SvgPicture.asset(
              AssetsManager.appBarLogo,
              height: 22.h,
              width: 66.w,
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0.r),
              topRight: Radius.circular(30.0.r),
            ),
            child: BottomNavigationBar(
              currentIndex: viewModel.currentIndex,
              onTap: (index) {
                viewModel.setCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetsManager.iconHomeUnSelected),
                  activeIcon: SvgPicture.asset(AssetsManager.iconHomeSelected),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetsManager.iconCategoryUnSelected),
                  activeIcon: SvgPicture.asset(AssetsManager.iconCategorySelected),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetsManager.iconWishlistUnSelected),
                  activeIcon: SvgPicture.asset(AssetsManager.iconWishlistSelected),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetsManager.iconProfileUnSelected),
                  activeIcon: SvgPicture.asset(AssetsManager.iconProfileSelected),
                  label: '',
                ),
              ],
            ),
          ),
          body: Container(
            padding: REdgeInsets.all(10),
            child: widgetsList[viewModel.currentIndex],
          ),
        );
      },
    );
  }
}
