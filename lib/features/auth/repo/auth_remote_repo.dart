// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constants.dart';
import 'package:spotify_clone/core/failure/failure.dart';
import 'package:spotify_clone/features/auth/model/sign_up_model.dart';
import 'package:http/http.dart' as http;
part 'auth_remote_repo.g.dart';

@riverpod
AuthRemoteRepo authRemoteRepo(AuthRemoteRepoRef ref) {
  return AuthRemoteRepo();
}

class AuthRemoteRepo {
  Future<Either<AppFailure, UserSignUpModel>> executeSignUp(
      {required UserSignUpModel user}) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.serverBaseUrl}auth/signUpUser"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'password': user.password
        }),
      );
      //  log("class:auth_remote_repo.dart \n response: ${response.body} == ${response.statusCode} \n");
      var decocedResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(decocedResponse['detail']));
      }
      return Right(UserSignUpModel.fromMap(decocedResponse));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserSignUpModel>> exectueLogin(
      {required UserSignUpModel user}) async {
    final response = await http.post(
      Uri.parse("${ServerConstant.serverBaseUrl}auth/loginUser"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': user.email, 'password': user.password}),
    );

    if (response.statusCode != 200) {
      return Left(AppFailure(response.body));
    }
    var decocedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    log("Initial Response : ${response.body} \ndecoded Response : $decocedResponse \n converted from map ${UserSignUpModel.fromMap(decocedResponse)}");
    return Right(UserSignUpModel.fromMap(decocedResponse['user'])
        .copyWith(token: decocedResponse['token']));
  }

  Future<Either<AppFailure, UserSignUpModel>> getCurrentUserData(
      String token) async {
    try {
      final response = await http.get(
        Uri.parse("${ServerConstant.serverBaseUrl}auth/"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      log("getCurrentUserData jsonDecode ${jsonDecode(response.body)}");

      var decocedResponse = jsonDecode(response.body) as Map<String, dynamic>;

      log("getCurrentUserData $decocedResponse");
      if (response.statusCode != 200) {
        return Left(AppFailure(decocedResponse['detail']));
      }

      return Right(
          UserSignUpModel.fromMap(decocedResponse).copyWith(token: token));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
