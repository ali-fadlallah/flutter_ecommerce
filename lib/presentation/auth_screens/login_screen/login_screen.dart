import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/constants/regex.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_auth_button.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_auth_text_field.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/routes/routes_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/presentation/auth_screens/login_screen/viewmodel/signin_view_model_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/auth_screens/viewmodel/auth_screens_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthScreensCubit viewModel = getIt<AuthScreensCubit>();

  SignInViewModelCubit viewModelSignIn = getIt<SignInViewModelCubit>();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    viewModel.togglePassword();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
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
                  height: 71.h,
                ),
                Text(
                  StringsManager.welcomeBackToRoute,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  StringsManager.pleaseSignInWithYourMail,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: 40.h,
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
                  bloc: viewModel,
                  builder: (context, state) {
                    if (state is AuthScreensTogglePassword) {
                      return CustomAuthTextField(
                        textFieldLabel: StringsManager.password,
                        controller: passwordController,
                        hintText: StringsManager.enterYourPassword,
                        secureText: viewModel.passwordVisible,
                        passwordIconVisibility: GestureDetector(
                          onTap: () {
                            viewModel.togglePassword();
                          },
                          child: Icon(
                            viewModel.passwordVisible ? Icons.visibility_off : Icons.visibility,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    StringsManager.forgotPassword,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                BlocConsumer<SignInViewModelCubit, SignInViewModelState>(
                  bloc: viewModelSignIn,
                  listener: (context, state) {
                    if (state is SignInViewModelOnError) {
                      Fluttertoast.showToast(
                          msg: state.errorMsg ?? '',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }

                    if (state is SignInViewModelOnSuccess) {
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
                    if (state is SignInViewModelOnLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    return CustomAuthButton(
                      buttonTitle: StringsManager.login,
                      onItemPressed: () {
                        if (formKey.currentState!.validate()) {
                          viewModelSignIn.signIn(emailController.text, passwordController.text);
                        } else {
                          return;
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 32.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      StringsManager.doNotHaveAccount,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesManager.registerRouteName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
