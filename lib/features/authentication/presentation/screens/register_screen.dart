import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/config/routes/page_routes_name.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/features/authentication/presentation/manager/sign_up/signup_viewmodel_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/regex.dart';
import '../../../../core/reusable_components/custom_auth_text_field.dart';
import '../../../../core/reusable_components/custom_button.dart';
import '../../../../core/utils/assets/assets_manager.dart';
import '../../../../core/utils/toast/show_toast.dart';
import '../manager/sign_up/signup_viewmodel_state.dart';

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
  SignupViewModelCubit viewModel = getIt<SignupViewModelCubit>();
  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
                  textFieldLabel: AppLocalizations.of(context)!.fullName,
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  hintText: AppLocalizations.of(context)!.enterYourFullName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterYourFullName;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomAuthTextField(
                  textFieldLabel: AppLocalizations.of(context)!.mobileNumber,
                  controller: mobileController,
                  hintText: AppLocalizations.of(context)!.enterYourMobile,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterYourMobile;
                    }
                    if (CustomRegex.isMobile(value) == false) {
                      return AppLocalizations.of(context)!.enterValidMobile;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomAuthTextField(
                  textFieldLabel: AppLocalizations.of(context)!.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.enterYourEmailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || CustomRegex.isValidEmail(value) == false) {
                      return AppLocalizations.of(context)!.enterValidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<SignupViewModelCubit, SignupViewModelState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    return CustomAuthTextField(
                      textFieldLabel: AppLocalizations.of(context)!.password,
                      controller: passwordController,
                      hintText: AppLocalizations.of(context)!.enterYourPassword,
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
                          return AppLocalizations.of(context)!.enterValidPassword;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context)!.weakPassword;
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  height: 40.h,
                ),
                BlocConsumer<SignupViewModelCubit, SignupViewModelState>(
                  bloc: viewModel,
                  listener: (context, state) {
                    if (state is SignupViewModelOnError) {
                      ShowToast.showError(state.errorMsg ?? '');
                    }
                    if (state is SignupViewModelOnSuccess) {
                      Navigator.pushNamedAndRemoveUntil(context, PageRoutesNames.homeRouteName, (route) => false);
                      ShowToast.showSuccess(AppLocalizations.of(context)!.loggedSuccessfully);
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
                    return CustomButton(
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      buttonTitle: AppLocalizations.of(context)!.signUp,
                      onItemPressed: () {
                        if (formKey.currentState!.validate()) {
                          viewModel.signUp(
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
