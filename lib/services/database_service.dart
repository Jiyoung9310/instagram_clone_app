import 'package:instagram_clone_app/models/user_model.dart';
import 'package:instagram_clone_app/util/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name' : user.name,
      'profileImageUrl' : user.profileImageUrl,
      'bio' : user.bio,
    });
  }
}