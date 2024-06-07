import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/features/authentication/presentation/manager/sign_in/signin_view_model_cubit.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../../core/global/global_imports.dart';
import '../manager/sign_in/signin_view_model_state.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignInViewModelCubit viewModelSignIn = getIt<SignInViewModelCubit>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInViewModelCubit>(
      create: (context) => viewModelSignIn,
      child: Scaffold(
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
                    AppLocalizations.of(context)!.welcomeBackToRoute,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.pleaseSignInWithYourMail,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 40.h,
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
                  BlocBuilder<SignInViewModelCubit, SignInViewModelState>(
                    bloc: viewModelSignIn,
                    builder: (context, state) {
                      return CustomAuthTextField(
                        textFieldLabel: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        hintText: AppLocalizations.of(context)!.enterYourPassword,
                        secureText: viewModelSignIn.passwordVisible,
                        passwordIconVisibility: GestureDetector(
                          onTap: () {
                            viewModelSignIn.togglePassword();
                          },
                          child: Icon(
                            viewModelSignIn.passwordVisible ? Icons.visibility_off : Icons.visibility,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
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
                        ShowToast.showError(state.errorMsg ?? '');
                      }

                      if (state is SignInViewModelOnSuccess) {
                        Navigator.pushNamedAndRemoveUntil(context, PageRoutesNames.homeRouteName, (route) => false);
                        ShowToast.showSuccess(AppLocalizations.of(context)!.loggedSuccessfully);
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
                      return CustomButton(
                        textStyle: Theme.of(context).textTheme.headlineMedium,
                        buttonTitle: AppLocalizations.of(context)!.login,
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
                        AppLocalizations.of(context)!.doNotHaveAccount,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutesNames.registerRouteName);
                      },
                    ),
                  ),
                  BlocBuilder<SignInViewModelCubit, SignInViewModelState>(
                    builder: (context, state) {
                      if (state is GoogleAuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GoogleAuthSuccess) {
                        return Center(
                          child: Column(
                            children: [
                              Text(state.user.email ?? ""),
                              Text(state.user.displayName ?? ""),
                              Text("accessToken: ${state.user.accessToken ?? ""}"),
                              Text("googleId: ${state.user.googleId ?? ""}"),
                              Image.network(state.user.photoUrl!, height: 100),
                              ElevatedButton(
                                child: Text('Sign Out'),
                                onPressed: () {
                                  viewModelSignIn.signOutGoogle();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: SignInButton(
                            Buttons.GoogleDark,
                            onPressed: () => viewModelSignIn.signInWithGoogle(),
                          ),
                        );
                      }
                    },
                  ),
                  BlocBuilder<SignInViewModelCubit, SignInViewModelState>(
                    builder: (context, state) {
                      if (state is AppleAuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AppleAuthSuccess) {
                        return Center(
                          child: Column(
                            children: [
                              Text(state.user.email ?? ""),
                              Text(state.user.displayName ?? ""),
                              Text("accessToken: ${state.user.accessToken ?? ""}"),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              SignInButton(
                                Buttons.AppleDark,
                                onPressed: () => viewModelSignIn.signInWithApple(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
