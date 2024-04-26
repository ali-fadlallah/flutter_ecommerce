import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/routes/routes_manager.dart';
import 'package:flutter_ecommerce_app/presentation/auth_screens/register_screen/viewmodel/signup_viewmodel_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/constants/regex.dart';
import '../../../core/reusable_components/custom_auth_button.dart';
import '../../../core/reusable_components/custom_auth_text_field.dart';
import '../../../core/utils/assets/assets_manager.dart';
import '../../../core/utils/strings/strings_manager.dart';
import '../viewmodel/auth_screens_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthScreensCubit authViewModel = getIt<AuthScreensCubit>();

  SignupViewModelCubit signUpViewModel = getIt<SignupViewModelCubit>();
  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    authViewModel.togglePassword();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: REdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 71.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AssetsManager.appBarLogo,
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 71.h,
                    width: 237.w,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomAuthTextField(
                  textFieldLabel: StringsManager.fullName,
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  hintText: StringsManager.enterYourFullName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.enterYourFullName;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomAuthTextField(
                  textFieldLabel: StringsManager.mobileNumber,
                  controller: mobileController,
                  hintText: StringsManager.enterYourMobile,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.enterYourMobile;
                    }
                    if (CustomRegex.isMobile(value) == false) {
                      return StringsManager.enterValidMobile;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomAuthTextField(
                  textFieldLabel: StringsManager.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: StringsManager.enterYourEmailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || CustomRegex.isValidEmail(value) == false) {
                      return StringsManager.enterValidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<AuthScreensCubit, AuthScreensState>(
                  bloc: authViewModel,
                  builder: (context, state) {
                    if (state is AuthScreensTogglePassword) {
                      return CustomAuthTextField(
                        textFieldLabel: StringsManager.password,
                        controller: passwordController,
                        hintText: StringsManager.enterYourPassword,
                        secureText: authViewModel.passwordVisible,
                        passwordIconVisibility: GestureDetector(
                          onTap: () {
                            authViewModel.togglePassword();
                          },
                          child: Icon(
                            authViewModel.passwordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.enterValidPassword;
                          }
                          if (value.length < 6) {
                            return StringsManager.weakPassword;
                          }
                          return null;
                        },
                      );
                    }
                    ;
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  height: 40.h,
                ),
                BlocConsumer<SignupViewModelCubit, SignupViewModelState>(
                  bloc: signUpViewModel,
                  listener: (context, state) {
                    if (state is SignupViewModelOnError) {
                      Fluttertoast.showToast(
                          msg: state.errorMsg ?? '',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    if (state is SignupViewModelOnSuccess) {
                      SharedPreferenceHelper.saveToken(state.authEntity?.token ?? '');
                      Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeRouteName, (route) => false);
                      Fluttertoast.showToast(
                          msg: StringsManager.loggedSuccessfully,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupViewModelOnLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    return CustomAuthButton(
                      buttonTitle: StringsManager.signUp,
                      onItemPressed: () {
                        if (formKey.currentState!.validate()) {
                          signUpViewModel.signUp(
                              name: fullNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: mobileController.text);
                        } else {
                          return;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
