import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/config/routes/page_routes_name.dart';
import 'package:flutter_ecommerce_app/core/utils/custom_dialog/my_custom_dialogs.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/fawry_gateway/presentation/manager/fawry_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../fawry_gateway/presentation/manager/fawry_cubit.dart';

class CartCheckOut extends StatefulWidget {
  final int? totalAmount;

  const CartCheckOut({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<CartCheckOut> createState() => _CartCheckOutState();
}

class _CartCheckOutState extends State<CartCheckOut> {
  FawryCubit viewModel = FawryCubit();

  @override
  void initState() {
    super.initState();
    viewModel.initSDKCallback();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.fawryCallbackResultStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  StringsManager.totalPrice,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                      ),
                ),
                Text(
                  '${StringsManager.EGP} ${widget.totalAmount ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: BlocConsumer<FawryCubit, FawryState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state is FawrySuccess) {
                  MyCustomDialogs.showMessageDialog(
                    context: context,
                    message: StringsManager.paymentComplete,
                    positiveTitle: StringsManager.okAlertDialog,
                    positiveClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageRoutesNames.homeRouteName,
                        (route) => false,
                      );
                    },
                  );
                }
                if (state is FawryError) {
                  MyCustomDialogs.showMessageDialog(
                    context: context,
                    message: StringsManager.paymentError,
                    positiveTitle: StringsManager.okAlertDialog,
                    positiveClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageRoutesNames.homeRouteName,
                        (route) => false,
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is FawryOnLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    FawryCubit.updateItemPrice(widget.totalAmount?.toDouble() ?? 0);
                    viewModel.startPayment(FawryCubit.model);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManager.checkOut,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const Icon(Icons.arrow_forward_outlined, color: Colors.white),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
