import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/access_firebase_token.dart';
import 'package:doctor_book/base/notification_service.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/choose_doctor/presentation/blocs/get_doctor/get_doctor_bloc.dart';
import 'package:doctor_book/features/forgot_password/presentation/blocs/bloc/forgot_password_bloc.dart';
import 'package:doctor_book/features/home/presentation/blocs/search/search_bloc.dart';
import 'package:doctor_book/features/info_patient/presentation/blocs/bloc/info_patient_bloc.dart';
import 'package:doctor_book/features/process_schedule/presentation/blocs/bloc/process_schedule_bloc.dart';
import 'package:doctor_book/features/schedule/presentation/blocs/schedule/schedule_bloc.dart';
import 'package:doctor_book/features/sign_in/presentation/blocs/bloc/sign_in_bloc.dart';
import 'package:doctor_book/features/sign_up/presentation/blocs/create_user/create_user_bloc.dart';
import 'package:doctor_book/firebase_options.dart';
import 'package:doctor_book/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(false);
  await NotificationService().init();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  log('FCMToken: $fcmToken');
  UserSingleton().updatePushToken(pushToken: fcmToken ?? '');

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Foreground message received: ${message.notification!.body}');
    if (UserSingleton().email.contains('doctor')) {
      NotificationService().showNotification(
        2,
        "Hãy xác nhận lịch hẹn",
        message.notification!.body,
      );
    } else {
      NotificationService().showNotification(
        2,
        message.notification!.title,
        message.notification!.body,
      );
    }
  });

  String bearerToken = await AccessFirebaseToken().getAccessToken();
  print('bearToken: $bearerToken');

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('Message opened from terminated state: ${message.notification!.body}');
    NotificationService().showNotification(
      2,
      message.notification!.title,
      message.notification!.body,
    );
  });

  runApp(const MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CreateUserBloc()),
        BlocProvider(create: (_) => GetDoctorBloc()),
        BlocProvider(create: (_) => ProcessScheduleBloc()),
        BlocProvider(create: (_) => InfoPatientBloc()),
        BlocProvider(create: (_) => SignInBloc()),
        BlocProvider(create: (_) => ForgotPasswordBloc()),
        BlocProvider(create: (_) => ScheduleBloc()),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi'),
            ],
            routerConfig: router,
          );
        },
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               final firestoreInstance = FirebaseFirestore.instance;
//               firestoreInstance.collection("bacsi").add({
//                 "name": "john",
//                 "age": 50,
//                 "email": "example@example.com",
//                 "address": {"street": "street 24", "city": "new york"}
//               }).then((value) {
//                 print(value.id);
//               });
//             },
//             child: const Text('ADD DATA')),
//       ),
//     );
//   }
// }
