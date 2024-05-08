import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_check_out.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
        create: (context) => getIt<CartCubit>()..getCart(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(StringsManager.cart),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
              onPressed: () => Navigator.pop(context, true),
            ),
            actions: [
              BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) {
                  if (current is GetCartOnSuccess) return true;
                  if (current is EmptyCartOnSuccess) return true;
                  if (current is ClearCartOnSuccess) return true;
                  return false;
                },
                builder: (context, state) {
                  if (state is GetCartOnSuccess) {
                    return IconButton(
                      icon: const Icon(Icons.remove_shopping_cart, color: Colors.redAccent),
                      onPressed: () {
                        CartCubit.get(context).clearCart();
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          body: BlocConsumer<CartCubit, CartState>(
            listener: (BuildContext context, CartState state) {},
            buildWhen: (previous, current) {
              if (current is UpdateCountLoadingState || current is DeleteItemLoadingState) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is GetCartOnSuccess) {
                return Container(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => CartItem(
                                  cartItemEntity: state.cartResponseEntity?.data?.products?[index],
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
              if (state is EmptyCartOnSuccess || state is ClearCartOnSuccess) {
                return const Center(child: Text(StringsManager.noItemsAvailable));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
