import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';

import 'home_brands_widget.dart';

class HomeBrands extends StatefulWidget {
  const HomeBrands({Key? key}) : super(key: key);

  @override
  _HomeBrandsState createState() => _HomeBrandsState();
}

class _HomeBrandsState extends State<HomeBrands> {
  HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeInitiateState>(
      bloc: viewModel,
      listenWhen: (previous, current) {
        if (current is BrandsOnLoading) return true;
        if (current is BrandsOnError) return true;
        if (current is BrandsOnSuccess) return true;
        return true;
      },
      listener: (context, state) {
        // if (state is BrandsOnLoading) {
        //   return MyCustomDialogs.showLoadingDialog(context: context, text: StringsManager.loadingAlertDialog);
        // }
        if (state is BrandsOnSuccess) {
          // MyCustomDialogs.hideLoadingDialog(context: context);
        }
      },
      buildWhen: (previous, current) {
        if (current is BrandsOnSuccess) return true;
        return false;
      },
      builder: (context, state) {
        if (state is BrandsOnSuccess) {
          return HomeBrandsWidget(brandsList: state.brandsList);
        }
        return Container();
      },
    );
  }
}
