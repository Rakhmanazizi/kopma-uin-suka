import 'model/user/user_model.dart';

abstract class UserRepository {
  Future<void> setUserData(UserModel user);

  Future<UserModel> getMyUser(String myUserId);
}
