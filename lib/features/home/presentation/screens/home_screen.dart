import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/page_routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeViewModel.get(context).currentIndex;
    HomeViewModel.get(context).getCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeInitiateState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            title: SvgPicture.asset(
              AssetsManager.appBarLogo,
              height: 22.h,
              width: 66.w,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, PageRoutesNames.cartRouteName);
                  if (result != null && mounted) {
                    HomeViewModel.get(context).getCartCount();
                  }
                },
                icon: Badge(
                  label: Text('${HomeViewModel.get(context).numOfItem}'),
                  child: const Icon(Icons.shopping_cart),
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
