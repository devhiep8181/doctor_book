import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/utils/process_datetime.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_show_dialog.dart';
import 'package:doctor_book/common/widgets/custom_text_form_filed.dart';
import 'package:doctor_book/common/widgets/custom_toast.dart';
import 'package:doctor_book/features/info_patient/data/models/patient_model.dart';
import 'package:doctor_book/features/info_patient/presentation/blocs/bloc/info_patient_bloc.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class InfoPatientScreen extends StatefulWidget {
  const InfoPatientScreen({super.key});

  @override
  State<InfoPatientScreen> createState() => _InfoPatientScreenState();
}

class _InfoPatientScreenState extends State<InfoPatientScreen> {
  ValueNotifier<bool> isSex = ValueNotifier<bool>(false);
  ValueNotifier<bool> isAddressCity = ValueNotifier<bool>(false);
  ValueNotifier<bool> isAddressDistrict = ValueNotifier<bool>(false);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: UserSingleton().email);
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _birthController.dispose();
    _sexController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text(
          'Tạo hồ sơ khám bệnh',
          style: AppStyles.whiteText,
        ),
      ),
      bottomNavigationBar: BlocListener<InfoPatientBloc, InfoPatientState>(
        listener: (context, state) {
          if (state.infoPatientStatus.isSuccess) {
            CustomShowDialog.showDialogAwesome(
                context,
                DialogType.success,
                'Tạo hồ sơ bệnh nhân thành công!',
                'Vui lòng ấn tiếp tục để chuyển đến trang chủ',
                () => context.pop(),
                () => context.goNamed(home));
          } else if (state.infoPatientStatus == InfoPatientStatus.error) {
            Fluttertoast.showToast(
                msg: "Đã có lỗi xảy ra, vui lòng thử lại",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Container(
          height: 50.h,
          margin: const EdgeInsets.symmetric(horizontal: 16)
              .copyWith(top: 16, bottom: 8),
          child: CustomElevatedButton(
            onPressed: () {
              if (_nameController.text != '' &&
                  _phoneController.text != '' &&
                  _birthController.text != '' &&
                  _sexController.text != '') {
                context.read<InfoPatientBloc>().add(SaveInfoPatientEvent(
                    patientModel: PatientModel(
                        uid: const Uuid().v8(),
                        fullName: _nameController.text,
                        phoneNumber: _phoneController.text,
                        birthDay: _birthController.text,
                        gender: _sexController.text,
                        email: _emailController.text,
                        city: _cityController.text,
                        district: _districtController.text)));
              } else {
                CustomToast.showToast(
                    context, 'Không được bỏ trống những trường bắt buộc');
              }
            },
            textBtn: 'Tạo hồ sơ bệnh nhân',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              const RemidWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Họ và tên',
                            style: AppStyles.body2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black87Color),
                            children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(color: AppColors.redColor))
                        ])),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: 'Vui lòng nhập họ và tên',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Số điện thoại',
                            style: AppStyles.body2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black87Color),
                            children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(color: AppColors.redColor))
                        ])),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _phoneController,
                      hintText: 'Vui lòng nhập số điện thoại',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Ngày sinh',
                            style: AppStyles.body2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black87Color),
                            children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(color: AppColors.redColor))
                        ])),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      readOnly: true,
                      controller: _birthController,
                      hintText: 'dd/mm/yy',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                      suffix: IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now(), // Ngày mặc định khi mở picker
                              firstDate:
                                  DateTime(1900), // Giới hạn ngày đầu tiên
                              lastDate:
                                  DateTime(2050), // Giới hạn ngày cuối cùng
                              locale: const Locale(
                                  'vi', 'VN'), // Thiết lập ngôn ngữ tiếng Việt
                            );
                            setState(() {
                              _birthController.text =
                                  ProcessDatetime.formatDate(
                                      picked ?? DateTime.now());
                            });
                          },
                          icon: const Icon(Icons.event_note)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Giới tính',
                            style: AppStyles.body2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black87Color),
                            children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(color: AppColors.redColor))
                        ])),
                    const SizedBox(
                      height: 8,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isSex,
                      builder: (context, value, child) => Column(
                        children: [
                          CustomTextFormField(
                              readOnly: true,
                              controller: _sexController,
                              hintText: 'Vui lòng chọn',
                              hintStyle: AppStyles.body2.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black87Color),
                              suffix: IconButton(
                                  onPressed: () {
                                    isSex.value = !isSex.value;
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_down))),
                          AnimatedContainer(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColors.grey200Color,
                                  borderRadius: BorderRadius.circular(20.r)),
                              width: isSex.value ? context.isWidthScreen : 0,
                              height: isSex.value ? 150 : 0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _sexController.text = 'Nam';
                                          isSex.value = !isSex.value;
                                        });
                                      },
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Nam',
                                          style: AppStyles.body2.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black87Color),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: AppColors.black54Color,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _sexController.text = 'Nữ';
                                        isSex.value = !isSex.value;
                                      },
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Nữ',
                                          style: AppStyles.body2.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black87Color),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: AppColors.black54Color,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _sexController.text = 'Khác';
                                        isSex.value = !isSex.value;
                                      },
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Khác',
                                          style: AppStyles.body2.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black87Color),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Địa chỉ email',
                      style: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.black87Color),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      readOnly: true,
                      hintText: 'Vui lòng nhập',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Tỉnh/Thành Phố',
                      style: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.black87Color),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _cityController,
                      hintText: 'Chọn Tỉnh/Thành Phố',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                      suffix: const Icon(Icons.keyboard_arrow_down),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Quận/Huyện',
                      style: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.black87Color),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _districtController,
                      hintText: 'Chọn Quận/Huyện',
                      hintStyle: AppStyles.body2.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black87Color),
                      suffix: const Icon(Icons.keyboard_arrow_down),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RemidWidget extends StatefulWidget {
  const RemidWidget({
    super.key,
  });

  @override
  State<RemidWidget> createState() => _RemidWidgetState();
}

class _RemidWidgetState extends State<RemidWidget> {
  ValueNotifier<bool> isExpanded = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (_, __, ___) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: !isExpanded.value
                      ? Radius.circular(20.r)
                      : const Radius.circular(0),
                  bottomRight: !isExpanded.value
                      ? Radius.circular(20.r)
                      : const Radius.circular(0),
                ),
                color: AppColors.amberColor.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.report,
                        color: AppColors.orangeColor.withOpacity(0.7),
                      ),
                      const Text('Thông tin hồ sơ'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      isExpanded.value = !isExpanded.value;
                    },
                    icon: Icon(isExpanded.value
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up),
                  )
                ],
              ),
            ),
            AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.amberColor.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r))),
              width: isExpanded.value ? context.isWidthScreen : 0,
              height: isExpanded.value ? 150 : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: const Text(
                'Vui lòng nhập chính xác thông tin của bệnh nhân theo giấy tờ tuỳ thân(CCCD/CMND, BHYT). Các thông tin này sẽ được chuyển đến phòng khám mà bạn đặt lịch. Thông tin không chính xác có thể làm gián đoạn quá trình khám chữa bệnh của bạn.',
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
