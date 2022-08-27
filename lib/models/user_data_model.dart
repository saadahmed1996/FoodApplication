//User Data model
class UserDataModel {
  final String email;
  final String password;
  final String name;
  final String phone;

  UserDataModel(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});

  //Converting Objects into Json Format so apiclient can accept it.
  Map<String, dynamic> toJson() {
    //Maping from Obj map to Json Map.
    final Map<String, dynamic> data = <String, dynamic>{};
    data["f_name"] = this.name;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["password"] = this.password;
    return data;
  }
}
