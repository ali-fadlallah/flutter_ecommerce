import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_button.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_profile_text_field.dart';
import 'package:flutter_ecommerce_app/features/profile/presentation/manager/profile_view_model_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/page_routes_name.dart';
import '../../../../core/constants/my_regex.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  // ProfileViewModelCubit viewModel = getIt<ProfileViewModelCubit>();
  late TextEditingController controllerFullName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerMobile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerFullName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerMobile = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controllerFullName.dispose();
    controllerEmail.dispose();
    controllerMobile.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileViewModelCubit>()..fetchData(),
      child: BlocBuilder<ProfileViewModelCubit, ProfileViewModelState>(
        builder: (context, state) {
          if (state is ProfileViewModelOnSuccess) {
            return Container(
              padding: REdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      animate: true,
                      delay: const Duration(seconds: 1),
                      child: CustomButton(
                        textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                        height: 55.h,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        buttonTitle: AppLocalizations.of(context)!.addNewAddresses,
                        onItemPressed: () {
                          Navigator.pushNamed(context, PageRoutesNames.addressesLocationRouteName);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.welcome} ${state.authEntity.user?.name?.split(' ')[0]}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        IconButton(
                            onPressed: () {
                              ProfileViewModelCubit.get(context).showLanguageBottomSheet(context);
                            },
                            icon: const Icon(Icons.translate)),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          FadeInRight(
                            animate: true,
                            delay: const Duration(seconds: 1),
                            child: CustomProfileTextField(
                              textFieldLabel: AppLocalizations.of(context)!.yourFullName,
                              controller: controllerFullName..text = state.authEntity.user?.name ?? '',
                              validator: (value) {
                                value = value?.trim();
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.enterYourFullName;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          FadeInLeft(
                            animate: true,
                            delay: const Duration(seconds: 1),
                            child: CustomProfileTextField(
                              textFieldLabel: AppLocalizations.of(context)!.yourEmail,
                              controller: controllerEmail..text = state.authEntity.user?.email ?? '',
                              hintText: state.authEntity.user?.email ?? '',
                              validator: (value) {
                                if (value == null || value.isEmpty || CustomRegex.isValidEmail(value) == false) {
                                  return AppLocalizations.of(context)!.enterValidEmail;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          FadeInRight(
                            animate: true,
                            delay: const Duration(seconds: 1),
                            child: CustomProfileTextField(
                              textFieldLabel: AppLocalizations.of(context)!.yourMobileNumber,
                              controller: controllerMobile,
                              hintText: AppLocalizations.of(context)!.enterYourMobile,
                              validator: (value) {
                                if (value == null || value.isEmpty || CustomRegex.isMobile(value) == false) {
                                  return AppLocalizations.of(context)!.enterValidMobile;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          FadeInLeft(
                            animate: true,
                            delay: const Duration(seconds: 1),
                            child: CustomButton(
                              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                              height: 55.h,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              buttonTitle: AppLocalizations.of(context)!.submit,
                              onItemPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ProfileViewModelCubit.get(context)
                                      .updateData(name: controllerFullName.text, email: controllerEmail.text, phone: controllerMobile.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
