import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_check_out.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final CartCubit viewModel = getIt<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
        create: (context) => viewModel..getCart(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(StringsManager.cart),
            centerTitle: true,
          ),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is GetCartOnSuccess) {
                return Container(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => CartItem(
                                  cartItemEntity: state.cartResponseEntity!.data!.products![index],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount: state.cartResponseEntity!.data?.products?.length.toInt() ?? 0),
                      ),
                      CartCheckOut(totalAmount: state.cartResponseEntity!.data?.totalCartPrice?.toInt() ?? 0),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
