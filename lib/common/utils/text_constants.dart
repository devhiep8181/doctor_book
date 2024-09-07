class TextConstant {
  TextConstant._();
  static String inputEmpty = '* Không được để trống';
  static RegExp validateEmail =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  static String emailError = '* Email không đúng định dạng';
  static String passwordError = '* Mật khẩu có 6 kí tự trở lên';
  static String passwordError2 = '* Mật khẩu xác nhận không khớp';

  static RegExp validatePassword =
      RegExp(r'(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])');

  static String homeLabel = 'Trang chủ';
  static String scheduleLabel = 'Lịch hẹn';
  static String chatLabel = 'Trò chuyện';
  static String accountLabel = 'Tài khoản';
  static String accountDoctor = 'doctor1@gmail.com';
}
