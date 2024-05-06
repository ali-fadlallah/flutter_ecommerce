import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';
import 'package:flutter_ecommerce_app/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/update_profile_data_use_case.dart';
import '../widgets/language_bottom_sheet_widget.dart';

part 'profile_view_model_state.dart';

@injectable
class ProfileViewModelCubit extends Cubit<ProfileViewModelState> {
  GetProfileDataUseCase getProfileDataUseCase;

  UpdateProfileDataUseCase updateProfileDataUseCase;
  @factoryMethod
  ProfileViewModelCubit(this.getProfileDataUseCase, this.updateProfileDataUseCase) : super(ProfileViewModelInitial());

  static ProfileViewModelCubit get(context) => BlocProvider.of(context);

  fetchData() async {
    emit(ProfileViewModelOnLoading());
    var result = await getProfileDataUseCase.call();
    result?.fold((authEntity) {
      emit(ProfileViewModelOnSuccess(authEntity));
    }, (error) {
      emit(ProfileViewModelOnError(error));
    });
  }

  updateData({required String name, required String email, required String phone}) async {
    emit(ProfileViewModelOnLoading());
    var result = await updateProfileDataUseCase.call(name: name, email: email, phone: phone);
    result?.fold((authEntity) {
      emit(ProfileViewModelOnSuccess(authEntity));
    }, (error) {
      emit(ProfileViewModelOnError(error));
    });
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheetWidget(),
    );
  }
}
