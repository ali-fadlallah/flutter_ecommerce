import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_button.dart';
import 'package:flutter_ecommerce_app/core/reusable_components/custom_profile_text_field.dart';
import 'package:flutter_ecommerce_app/features/profile/presentation/manager/profile_view_model_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/regex.dart';
import '../../../../core/utils/strings/strings_manager.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  ProfileViewModelCubit viewModel = getIt<ProfileViewModelCubit>();
  late TextEditingController controllerFullName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerMobile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerFullName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerMobile = TextEditingController();
    viewModel.fetchData();
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
    return BlocBuilder<ProfileViewModelCubit, ProfileViewModelState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is ProfileViewModelOnSuccess) {
          return Container(
            padding: REdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${StringsManager.welcome} ${state.authEntity.user?.name?.split(' ')[0]}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          textFieldLabel: StringsManager.yourFullName,
                          controller: controllerFullName..text = state.authEntity.user?.name ?? '',
                          validator: (value) {
                            value = value?.trim();
                            if (value == null || value.isEmpty) {
                              return StringsManager.enterYourFullName;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomProfileTextField(
                          textFieldLabel: StringsManager.yourEmail,
                          controller: controllerEmail..text = state.authEntity.user?.email ?? '',
                          hintText: state.authEntity.user?.email ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty || CustomRegex.isValidEmail(value) == false) {
                              return StringsManager.enterValidEmail;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomProfileTextField(
                          textFieldLabel: StringsManager.yourMobileNumber,
                          controller: controllerMobile,
                          hintText: StringsManager.enterYourMobile,
                          validator: (value) {
                            if (value == null || value.isEmpty || CustomRegex.isMobile(value) == false) {
                              return StringsManager.enterValidMobile;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomButton(
                          textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                          height: 55.h,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          buttonTitle: StringsManager.submit,
                          onItemPressed: () {
                            if (formKey.currentState!.validate()) {
                              viewModel.updateData(name: controllerFullName.text, email: controllerEmail.text, phone: controllerMobile.text);
                            }
                            ;
                          },
                        )
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
    );
  }
}
