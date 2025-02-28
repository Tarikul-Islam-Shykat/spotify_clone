// this provider is mainly for accesing user information globally. Like email, password etc. 

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/auth/model/sign_up_model.dart';
part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {

@override
  UserSignUpModel? build(){
    return null;
  }

  void addUser(UserSignUpModel user){
    state = user;
  }
}