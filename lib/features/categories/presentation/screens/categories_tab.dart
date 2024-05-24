import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/utils/colors/colors_manager.dart';
import 'package:flutter_ecommerce_app/features/sub_categories/presentation/screens/subcategory_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/categories_tab_view_model_cubit.dart';
import '../manager/categories_tab_view_model_state.dart';
import '../widgets/category_tab_item.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  CategoriesTabViewModelCubit viewModel = getIt<CategoriesTabViewModelCubit>();
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
    return BlocConsumer<CategoriesTabViewModelCubit, CategoriesTabViewModelState>(
      bloc: viewModel,
      listenWhen: (previous, current) {
        if (current is CategoriesTabViewModelOnLoading) return true;
        if (current is CategoriesTabViewModelOnError) return true;
        if (current is CategoriesTabViewModelOnSuccess) return true;
        return false;
      },
      listener: (context, state) {
        if (state is CategoriesTabViewModelOnError || state is CategoriesTabViewModelOnSuccess || state is CategoriesTabViewModelOnLoading) {
          // if (state is CategoriesTabViewModelOnLoading) {
          //   MyCustomDialogs.showLoadingDialog(context: context, text: AppLocalizations.of(context)!.loadingAlertDialog);
          // }

          // if (state is CategoriesTabViewModelOnError) {
          //   MyCustomDialogs.showMessageDialog(context: context, message: state.error ?? '');
          // }
          if (state is CategoriesTabViewModelOnSuccess) {
            // MyCustomDialogs.hideLoadingDialog(context: context);
            viewModel.getSpecificSubCategory(state.categoryEntityList[viewModel.selectedIndex].id ?? '');
          }
        }
      },
      buildWhen: (previous, current) {
        if (current is CategoriesTabViewModelOnSuccess) {
          return true;
        }
        if (current is CategoriesTabViewModelOnIndexChanged) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is CategoriesTabViewModelOnSuccess || state is CategoriesTabViewModelOnIndexChanged) {
          return Row(
            children: [
              Container(
                padding: REdgeInsets.all(5),
                width: 137.w,
                decoration: BoxDecoration(
                  color: ColorsManager.categoryBackgroundColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.30),
                  ),
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
                  itemCount: viewModel.categoryList.length,
                  itemBuilder: (context, index) {
                    return CategoryTabItem(
                      categoryEntity: viewModel.categoryList[index],
                      isSelected: index == viewModel.selectedIndex,
                      onItemClicked: () {
                        index = viewModel.getSelectedIndex(index);
                        viewModel.getSpecificSubCategory(viewModel.categoryList[viewModel.selectedIndex].id ?? '');
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: BlocBuilder<CategoriesTabViewModelCubit, CategoriesTabViewModelState>(
                  bloc: viewModel,
                  buildWhen: (previous, current) {
                    if (current is SubCategoriesTabViewModelOnSuccess ||
                        current is SubCategoriesTabViewModelOnLoading ||
                        current is SubCategoriesTabViewModelOnError) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    if (state is SubCategoriesTabViewModelOnLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SubCategoriesTabViewModelOnSuccess) {
                      return state.subcategoryEntityList.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.noItemsAvailable,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                          : SubcategoryWidget(subCategoryList: state.subcategoryEntityList);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
