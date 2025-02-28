// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/failure/failure.dart';
import 'package:spotify_clone/core/provider/current_user_notifier.dart';
import 'package:spotify_clone/features/auth/model/sign_up_model.dart';
import 'package:spotify_clone/features/auth/repo/auth_local_repo.dart';
import 'package:spotify_clone/features/auth/repo/auth_remote_repo.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepo _authRemoteRepo;
  late AuthLocalRepo _authLocalRepo;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserSignUpModel>? build() {
    _authRemoteRepo = ref.watch(
        authRemoteRepoProvider); // this will be able to get all the changes that occured
    _authLocalRepo = ref.watch(authLocalRepoProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPref() async {
    await _authLocalRepo.init();
  }

  Future<void> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    state = const AsyncValue.loading();
    var userInfo =
        UserSignUpModel(name: name, email: email, password: password);
    final response = await _authRemoteRepo.executeSignUp(user: userInfo);
    final val = switch (response) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    state = const AsyncValue.loading();
    var userInfo = UserSignUpModel(email: email, password: password);
    final response = await _authRemoteRepo.exectueLogin(user: userInfo);
    final val = switch (response) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _loginSuccesss(r)
    };
  }

  AsyncValue<UserSignUpModel>? _loginSuccesss(UserSignUpModel user) {
    _authLocalRepo.setAuthToken(user.token);
    _currentUserNotifier.addUser(
        user); // updating the current user notifier to access the value accross.
    return state = AsyncValue.data(user);
  }

  Future<UserSignUpModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepo.getToken();
    log("getData token found $token");
    if (token != null) {
      final res = await _authRemoteRepo.getCurrentUserData(token);
      log(" getData token found response $res");

      final val = switch (res) {
        Left(value: final l) => state =
            AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => _getDataSuccess(r),
        // Future<Either<AppFailure, UserSignUpModel>>() =>
        //   AsyncValue.error("Get Data Error", StackTrace.current),
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<UserSignUpModel> _getDataSuccess(UserSignUpModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
