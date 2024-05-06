import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/routes/routes_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final HomeTabViewModel viewModelTab = getIt<HomeTabViewModel>();

  // final HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    HomeViewModel.get(context).currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeInitiateState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: SvgPicture.asset(
              AssetsManager.appBarLogo,
              height: 22.h,
              width: 66.w,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesManager.cartRouteName);
                },
                icon: Badge(
                  child: Icon(Icons.shopping_cart),
                  label: Text('${HomeViewModel.get(context).numOfItem}'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0.r),
              topRight: Radius.circular(30.0.r),
            ),
            child: BottomNavigationBar(
              currentIndex: HomeViewModel.get(context).currentIndex,
              onTap: (index) {
                HomeViewModel.get(context).setCurrentIndex(index);
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
            child: HomeViewModel.get(context).widgetsList[HomeViewModel.get(context).currentIndex],
          ),
        );
      },
    );
  }
}
