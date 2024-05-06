import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/product_entity_item.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/di/di.dart';

class HomeMostSellingWidget extends StatefulWidget {
  const HomeMostSellingWidget({Key? key}) : super(key: key);

  @override
  State<HomeMostSellingWidget> createState() => _HomeMostSellingWidgetState();
}

class _HomeMostSellingWidgetState extends State<HomeMostSellingWidget> {
  HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMostSelling();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeInitiateState>(
      bloc: viewModel,
      buildWhen: (previous, current) {
        if (current is MostSellingOnSuccess || current is MostSellingOnError || current is MostSellingOnLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is MostSellingOnSuccess) {
          return SizedBox(
            height: 280.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductEntityItem(productEntity: state.mostSellingList[index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 20.w,
                    ),
                itemCount: state.mostSellingList.length),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
