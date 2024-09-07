class UserSingleton {
  //b3: phương thức tạo đối tượng
  factory UserSingleton() {
    return _instance;
  }
  //b1: tạo hàm tạo riêng tư
  UserSingleton._internal();

  //b2 biến tĩnh chứa đối tượng duy nhất
  static final UserSingleton _instance = UserSingleton._internal();

  String _email = '';
  String _name = '';
  String _pushToken = '';

  String get email => _email;
  String get name => _name;
  String get pushToken => _pushToken;

  void login({
    required String email,
    required String name,
  }) {
    _email = email;
    _name = name;
  }

  void updatePushToken({
    required String pushToken,
  }) {
    _pushToken = pushToken;
  }
}
