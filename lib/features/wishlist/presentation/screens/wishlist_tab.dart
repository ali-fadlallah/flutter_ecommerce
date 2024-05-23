import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_cubit.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_state.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/widgets/wish_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListCubit, WishListState>(
      bloc: getIt<WishListCubit>()..getWishList(),
      builder: (context, state) {
        if (state is GetWishListOnSuccess) {
          return state.productEntity!.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!.noItemsAvailable),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return WishListItem(productEntity: state.productEntity?[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 24.h,
                      ),
                  itemCount: state.productEntity?.length ?? 0);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
