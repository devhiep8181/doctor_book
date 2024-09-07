import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/utils/validator_function.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_show_dialog.dart';
import 'package:doctor_book/common/widgets/custom_text_form_filed.dart';
import 'package:doctor_book/features/forgot_password/presentation/blocs/bloc/forgot_password_bloc.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetsPasswordScreen extends StatefulWidget {
  const ResetsPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetsPasswordScreen> createState() => _ResetsPasswordScreenState();
}

class _ResetsPasswordScreenState extends State<ResetsPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordLoading) {
              CustomShowDialog.showDialogLoading(context);
            } else if (state is ForgotPasswordOk) {
              context.pop();
              CustomShowDialog.showDialogAwesome(
                  context,
                  DialogType.success,
                  'Đổi mật khẩu thành công',
                  'Vui lòng ấn tiếp tục để trải nghiệm dịch vụ',
                  () => context.pop(),
                  () => context.pushReplacementNamed(signin));
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => context.pushReplacementNamed(forgotPassword),
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
                  height: 50.h,
                ),
                Text(
                  'Quên mật khẩu',
                  style: AppStyles.headerLager,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  label: 'Mật khẩu mới',
                  controller: _passwordController,
                  validator: (value) =>
                      ValidatonFunction.validatePassword(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  label: 'Xác nhận mật khẩu',
                  validator: (value) => ValidatonFunction.validatePassword1(
                      value, _passwordController.text),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  textBtn: 'Xác nhận',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ForgotPasswordBloc>().add(UpdatePassword(
                          password: _passwordController.text,
                          email: widget.email));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
