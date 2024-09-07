import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? errorEmail;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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

              context.pushReplacementNamed(resetsPassword,extra: _emailController.text);
            } else if (state is ForgotPasswordError) {
              context.pop();
              setState(() {
                errorEmail = '* Email không tồn tại trong hệ thống';
              });
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => context.pushReplacementNamed(signin),
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
                  controller: _emailController,
                  errorText: errorEmail,
                  label: 'Email',
                  validator: (value) => ValidatonFunction.validateEmail(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  textBtn: 'Xác minh',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ForgotPasswordBloc>()
                          .add(CheckEmail(email: _emailController.text));
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
