import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/utils/text_constants.dart';
import 'package:doctor_book/common/utils/validator_function.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/common/widgets/custom_text_form_filed.dart';
import 'package:doctor_book/common/widgets/custom_toast.dart';
import 'package:doctor_book/features/sign_in/presentation/blocs/bloc/sign_in_bloc.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isVisbilityPassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorPassword;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Đăng Nhập',
              style: AppStyles.headerLager,
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomImageView(
              imagePath: Assets.images.logo,
            ),
            SizedBox(
              height: 70.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    label: 'Email',
                    validator: (value) =>
                        ValidatonFunction.validateEmail(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocListener<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state.signInStatus == SignInStatus.error) {
                        context.pop();
                        setState(() {
                          errorPassword =
                              '*Mật khẩu không chính xác, vui lòng thử lại';
                        });
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: isVisbilityPassword,
                      builder: (_, __, ___) => CustomTextFormField(
                        controller: _passwordController,
                        obscureText: isVisbilityPassword.value,
                        errorText: errorPassword,
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
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          context.pushReplacementNamed(forgotPassword);
                        },
                        child: Text(
                          'Quên mật khẩu',
                          style: AppStyles.headerSmall,
                        )),
                  ),
                  BlocListener<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state.signInStatus.isLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Không cho phép tắt dialog bằng cách bấm ngoài màn hình
                          builder: (context) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(
                                  height: 4.h,
                                ),
                                const Text('Vui lòng đợi....'),
                              ],
                            ),
                          ),
                        );
                      } else if (state.signInStatus.isSucees) {
                        context.pop();
                        if (UserSingleton().email ==
                            TextConstant.accountDoctor) {
                          context.goNamed(homedoctor);
                        } else {
                          context.goNamed(home);
                        }
                      } else if (state.signInStatus.isNoFind) {
                        context.pop();
                        CustomToast.showToast(context,
                            'Tài khoản không tồn tại. Vui lòng nhập lại hoặc đăng ký!');
                      }
                    },
                    child: CustomElevatedButton(
                      textBtn: 'Đăng Nhập',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(CheckAccount(
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn chưa có tài khoản?',
                  style: AppStyles.bodyMedium,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(signup);
                  },
                  child: Text(
                    ' Đăng ký',
                    style: AppStyles.headerSmall,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
