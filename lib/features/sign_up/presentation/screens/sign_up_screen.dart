import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/utils/validator_function.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/common/widgets/custom_show_dialog.dart';
import 'package:doctor_book/common/widgets/custom_text_form_filed.dart';
import 'package:doctor_book/common/widgets/custom_toast.dart';
import 'package:doctor_book/features/sign_up/presentation/blocs/create_user/create_user_bloc.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> isVisbilityPassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> isVisbilityPassword2 = ValueNotifier<bool>(true);
  String? errorEmail;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<CreateUserBloc, CreateUserState>(
            listener: (context, state) {
              if (state is CreateUserSuccess) {
               // context.pop();
                CustomShowDialog.showDialogAwesome(
                    context,
                    DialogType.success,
                    'Đăng kí thành công',
                    'Vui lòng ấn tiếp tục để trải nghiệm dịch vụ', () {
                  context.pop();
                }, () {
                  context.pushReplacementNamed(infoPatient);
                });
              } else if (state is CreateUserLoading) {
                // showDialog(
                //   context: context,
                //   barrierDismissible:
                //       false, // Không cho phép tắt dialog bằng cách bấm ngoài màn hình
                //   builder: (context) => Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const CircularProgressIndicator(),
                //         SizedBox(
                //           height: 4.h,
                //         ),
                //         const Text('Vui lòng đợi....'),
                //       ],
                //     ),
                //   ),
                // );
              } else if (state is CreateUserFailed) {
              // Navigator.of(context).pop();

                setState(() {
                  errorEmail = '* Email này đã tồn tại trong hệ thống';
                });
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Đăng ký',
                    style: AppStyles.headerLager,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomImageView(
                    imagePath: Assets.images.logo,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFormField(
                    controller: _nameController,
                    label: 'Họ và tên',
                    validator: (value) => ValidatonFunction.validateName(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    errorText: errorEmail,
                    label: 'Email',
                    validator: (value) =>
                        ValidatonFunction.validatePassword(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isVisbilityPassword,
                    builder: (_, __, ___) => CustomTextFormField(
                      controller: _passwordController,
                      obscureText: isVisbilityPassword.value,
                      label: 'Mật khẩu',
                      validator: (value) =>
                          ValidatonFunction.validatePassword(value),
                      suffix: IconButton(
                          onPressed: () {
                            isVisbilityPassword.value =
                                !isVisbilityPassword.value;
                          },
                          icon: Icon(isVisbilityPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isVisbilityPassword2,
                    builder: (_, __, ___) => CustomTextFormField(
                      obscureText: isVisbilityPassword2.value,
                      label: 'Xác nhận mật khẩu',
                      validator: (value) => ValidatonFunction.validatePassword1(
                          value, _passwordController.text),
                      suffix: IconButton(
                          onPressed: () {
                            isVisbilityPassword2.value =
                                !isVisbilityPassword2.value;
                          },
                          icon: Icon(isVisbilityPassword2.value
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomElevatedButton(
                    textBtn: 'Đăng ký',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CreateUserBloc>().add(CreatedUserWithEmail(
                            email: _emailController.text,
                            passWord: _passwordController.text,
                            name: _nameController.text));
                        // context.goNamed(home);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
