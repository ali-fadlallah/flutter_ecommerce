import 'dart:async';
import 'dart:convert';

import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fawry_sdk/fawry_utils.dart';
import 'package:fawry_sdk/model/bill_item.dart';
import 'package:fawry_sdk/model/fawry_launch_model.dart';
import 'package:fawry_sdk/model/launch_customer_model.dart';
import 'package:fawry_sdk/model/launch_merchant_model.dart';
import 'package:fawry_sdk/model/payment_methods.dart';
import 'package:fawry_sdk/model/response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../core/global/global_imports.dart';
import 'fawry_state.dart';

class FawryCubit extends Cubit<FawryState> {
  FawryCubit() : super(FawryInitial());

  static FawryCubit get(context) => BlocProvider.of(context);

  Future<void> startPayment(FawryLaunchModel model) async {
    emit(FawryOnLoading());
    try {
      await FawrySDK.instance.startPayment(
        launchModel: model,
        baseURL: dotenv.get('FAWRY_BASE_URL', fallback: null),
        lang: SharedPreferenceHelper.getData(key: StringsManager.keyLocale).toString() == 'ar' ? FawrySDK.LANGUAGE_ARABIC : FawrySDK.LANGUAGE_ENGLISH,
      );
      emit(FawryInitialSuccess());
    } catch (e) {
      emit(FawryError(e.toString()));
      debugPrint('Error starting payment: $e');
    }
  }

  late StreamSubscription? fawryCallbackResultStream;

  Future<void> initSDKCallback() async {
    try {
      fawryCallbackResultStream = FawrySDK.instance.callbackResultStream().listen((event) {
        ResponseStatus response = ResponseStatus.fromJson(jsonDecode(event));
        handleResponse(response);
      });
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void handleResponse(ResponseStatus response) {
    switch (response.status) {
      case FawrySDK.RESPONSE_SUCCESS:
        emit(FawrySuccess(response));
        break;
      case FawrySDK.RESPONSE_ERROR:
        emit(FawryError(response.message));
        break;
      case FawrySDK.RESPONSE_PAYMENT_COMPLETED:
        debugPrint('Payment Completed: ${response.message}, ${response.data}');
        break;
    }
  }

  static BillItem item = BillItem(
    itemId: 'ITEM_ID',
    description: '',
    quantity: 1,
    price: 50,
  );

  static LaunchCustomerModel customerModel = LaunchCustomerModel(
    customerProfileId: '533518',
    customerName: 'John Doe',
    customerEmail: 'john.doe@xyz.com',
    customerMobile: '+201066569888',
  );

  static LaunchMerchantModel getMerchantModel() {
    return LaunchMerchantModel(
      merchantCode: dotenv.get('FAWRY_MERCHANT_CODE', fallback: null),
      merchantRefNum: FawryUtils.randomAlphaNumeric(10),
      secureKey: dotenv.get('FAWRY_SECURE_KEY', fallback: null),
    );
  }

  static List<BillItem> chargeItems = [item];
  static FawryLaunchModel model = FawryLaunchModel(
    allow3DPayment: true,
    chargeItems: chargeItems,
    launchCustomerModel: customerModel,
    launchMerchantModel: getMerchantModel(),
    skipLogin: true,
    skipReceipt: false,
    payWithCardToken: false,
    paymentMethods: PaymentMethods.ALL,
  );

  static void updateItemPrice(double newPrice) {
    item.price = newPrice;
  }

  static void updateCustomerDetails({
    String? name,
    String? email,
    String? mobile,
  }) {
    if (name != null) customerModel.customerName = name;
    if (email != null) customerModel.customerEmail = email;
    if (mobile != null) customerModel.customerMobile = mobile;
  }
}
