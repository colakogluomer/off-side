import 'package:flutter/foundation.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/user_service.dart';

class CurrentUser extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> updateUser() async {
    _user = await UserService.getCurrentUser();
    notifyListeners();
  }
}
