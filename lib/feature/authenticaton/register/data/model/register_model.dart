class RegisterModel {
  String name;
  String password;
  String confirmPassword;
  String? pin;
  bool? isFingerprintEnabled;

  RegisterModel({
    required this.name,
    required this.password,
    required this.confirmPassword,
    this.pin,
    this.isFingerprintEnabled,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "confirmPassword": confirmPassword,
    "pin": pin,
    "finger": isFingerprintEnabled,
  };

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json["name"],
      password: json["password"],
      confirmPassword: json["confirmPassword"],
      pin: json["pin"],
      isFingerprintEnabled: json["finger"],
    );
  }
}
