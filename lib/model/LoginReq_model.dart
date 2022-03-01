class LoginReq_model {
  LoginReq_model({
    this.username,
    this.password,
  });
  late final String? username;
  late final String? password;

  LoginReq_model.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['password'] = this.password;
    return _data;
  }
}
