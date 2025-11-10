class LoginModel{
  String name;
  String password;
  LoginModel({required this.name,required this.password});

  LoginModel copyWith({String? name, String?password}) {
    return LoginModel(
        name: name ?? this.name, password: password ?? this.password);
  }
  Map <String,dynamic>toJson()=>{
    "name":name,
    "password":password
  };
 factory LoginModel.fromJson(Map<String,dynamic>json){
    return LoginModel(name:json["name"] , password: json["password"]);
  }
}
