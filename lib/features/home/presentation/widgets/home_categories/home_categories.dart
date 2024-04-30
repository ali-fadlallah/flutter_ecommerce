import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/utils/custom_dialog/my_custom_dialogs.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_tab_viewmodel.dart';

import 'home_categories_widget.dart';

class HomeCategories extends StatefulWidget {
  HomeCategories({Key? key}) : super(key: key);

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeInitiateState>(
      bloc: viewModel,
      listenWhen: (previous, current) {
        if (current is CategoriesOnLoading) return true;
        if (current is CategoriesOnError) return true;
        if (current is CategoriesOnSuccess) return true;
        return true;
      },
      listener: (context, state) {
        if (state is CategoriesOnLoading) {
          MyCustomDialogs.showLoadingDialog(context: context, text: StringsManager.loadingAlertDialog);
        }
        if (state is CategoriesOnError) {
          MyCustomDialogs.showMessageDialog(
            context: context,
            message: state.errorMsg ?? '',
            positiveTitle: StringsManager.okAlertDialog,
            positiveClick: () {
              MyCustomDialogs.hideLoadingDialog(context: context);
            },
          );
        }
        if (state is CategoriesOnSuccess) {
          MyCustomDialogs.hideLoadingDialog(context: context);
        }
      },
      buildWhen: (previous, current) {
        if (current is CategoriesOnLoading) return false;
        if (current is CategoriesOnError) return false;
        return true;
      },
      builder: (context, state) {
        if (state is CategoriesOnSuccess) {
          return HomeCategoriesWidget(state.categoryList);
        }
        return Container();
      },
    );
  }
}
