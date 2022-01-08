import 'package:frontend/services/networking.dart';

class UserModel {
  String name;
  String email;
  Uri profileImage;
  int teamId;

  static Future<dynamic> getUser(int id) async {
    NetworkHelper networkHelper = NetworkHelper('user endpoint');
    var userData = await networkHelper.getData();
    return UserModel(
        name: userData['name'],
        email: userData['email'],
        profileImage: userData['profileImage'],
        teamId: userData['teamId']);
  }

  UserModel(
      {required this.name,
      required this.email,
      required this.profileImage,
      required this.teamId});
}
