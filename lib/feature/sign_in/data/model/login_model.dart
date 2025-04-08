class LoginModel{
 final String email;
 final String password;

//<editor-fold desc="Data Methods">
  const LoginModel({
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'loginModel{' +
        ' username: $email,' +
        ' password: $password,' +
        '}';
  }

  LoginModel copyWith({
    String? username,
    String? password,
  }) {
    return LoginModel(
      email: username ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.email,
      'password': this.password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['username'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}