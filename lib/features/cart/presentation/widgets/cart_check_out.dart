import 'package:flutter_ecommerce_app/core/utils/custom_dialog/my_custom_dialogs.dart';
import 'package:flutter_ecommerce_app/features/payment_gateways/stripe_payment_gateway/presentation/manager/stripe_cubit.dart';

import '../../../../core/global/global_imports.dart';
import '../../../payment_gateways/fawry_payment_gateway/presentation/manager/fawry_cubit.dart';
import '../../../payment_gateways/fawry_payment_gateway/presentation/manager/fawry_state.dart';

class CartCheckOut extends StatefulWidget {
  final int? totalAmount;
  final int? paymentGatewaySource;

  const CartCheckOut({Key? key, required this.totalAmount, required this.paymentGatewaySource}) : super(key: key);

  @override
  State<CartCheckOut> createState() => _CartCheckOutState();
}

class _CartCheckOutState extends State<CartCheckOut> {
  late FawryCubit fawryCubit;
  late StripeCubit stripeCubit;

  @override
  void initState() {
    super.initState();
    if (widget.paymentGatewaySource == 1) {
      fawryCubit = FawryCubit();
      fawryCubit.initSDKCallback();
    } else if (widget.paymentGatewaySource == 2) {
      stripeCubit = StripeCubit();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.paymentGatewaySource == 1) {
      fawryCubit.fawryCallbackResultStream?.cancel();
    } else if (widget.paymentGatewaySource == 2) {}
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FawryCubit>(
          create: (context) => fawryCubit,
        ),
        BlocProvider<StripeCubit>(
          create: (context) => stripeCubit,
        ),
      ],
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.totalPrice,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                      ),
                ),
                Text(
                  '${AppLocalizations.of(context)!.egp} ${widget.totalAmount ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: widget.paymentGatewaySource == 1
                ? BlocConsumer<FawryCubit, FawryState>(
                    listenWhen: (previous, current) => true, // Listen for all state changes
                    listener: (context, state) {
                      if (state is FawrySuccess) {
                        MyCustomDialogs.showMessageDialog(
                          context: context,
                          message: AppLocalizations.of(context)!.paymentComplete,
                          positiveTitle: AppLocalizations.of(context)!.okAlertDialog,
                          positiveClick: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRoutesNames.homeRouteName,
                              (route) => false,
                            );
                          },
                        );
                      } else if (state is FawryError) {
                        MyCustomDialogs.showMessageDialog(
                          context: context,
                          message: AppLocalizations.of(context)!.paymentError,
                          positiveTitle: AppLocalizations.of(context)!.okAlertDialog,
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
                        onPressed: () async {
                          FawryCubit.updateItemPrice(widget.totalAmount?.toDouble() ?? 0);
                          fawryCubit.startPayment(FawryCubit.model);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.checkOut,
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
                  )
                : BlocConsumer<StripeCubit, StripeState>(
                    listenWhen: (previous, current) => true,
                    listener: (context, state) {
                      if (state is StripeOnSuccess) {
                        MyCustomDialogs.showMessageDialog(
                          context: context,
                          message: AppLocalizations.of(context)!.paymentComplete,
                          positiveTitle: AppLocalizations.of(context)!.okAlertDialog,
                          positiveClick: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRoutesNames.homeRouteName,
                              (route) => false,
                            );
                          },
                        );
                      } else if (state is StripeOnError) {
                        MyCustomDialogs.showMessageDialog(
                          context: context,
                          message: AppLocalizations.of(context)!.paymentError,
                          positiveTitle: AppLocalizations.of(context)!.okAlertDialog,
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
                      if (state is StripeOnLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                        onPressed: () async {
                          await stripeCubit.initPaymentSheet(widget.totalAmount?.toString() ?? "0", context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.checkOut,
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
          ),
        ],
      ),
    );
  }
}
