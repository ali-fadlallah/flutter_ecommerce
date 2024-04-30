import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';
import 'package:flutter_ecommerce_app/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/update_profile_data_use_case.dart';

part 'profile_view_model_state.dart';

@injectable
class ProfileViewModelCubit extends Cubit<ProfileViewModelState> {
  GetProfileDataUseCase getProfileDataUseCase;

  UpdateProfileDataUseCase updateProfileDataUseCase;
  @factoryMethod
  ProfileViewModelCubit(this.getProfileDataUseCase, this.updateProfileDataUseCase) : super(ProfileViewModelInitial());

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
}
