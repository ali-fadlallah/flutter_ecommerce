import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../../core/global/global_imports.dart';
import '../payment.dart';

part 'stripe_state.dart';

class StripeCubit extends Cubit<StripeState> {
  StripeCubit() : super(StripeInitial());

  Future<void> initPaymentSheet(String amount, BuildContext context) async {
    emit(StripeOnLoading());
    try {
      Stripe.publishableKey = dotenv.get('STRIPE_PUBLISH_KEY', fallback: null);
      await Stripe.instance.applySettings();
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
          // convert string to double
          amount: (int.parse(amount) * 100).toString(),
          currency: "EGP",
          name: "TEST",
          address: "TEST",
          pin: "123456",
          city: "TEST",
          state: "TEST",
          country: "TEST");

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: AppLocalizations.of(context)!.appName,
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.light,
        ),
      );
      try {
        await Stripe.instance.presentPaymentSheet();

        emit(StripeOnSuccess());
      } catch (e) {
        emit(StripeOnError());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }
}
