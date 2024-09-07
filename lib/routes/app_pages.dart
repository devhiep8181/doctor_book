// Flutter imports:
import 'package:doctor_book/common/widgets/scaffold_with_navbar.dart';
import 'package:doctor_book/features/chat/presentation/screens/chat_screen.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:doctor_book/features/choose_doctor/presentation/blocs/get_doctor/get_doctor_bloc.dart';
import 'package:doctor_book/features/choose_doctor/presentation/screens/choose_doctor_screen.dart';
import 'package:doctor_book/features/doctors/presentation/screens/appointment_screen.dart';
import 'package:doctor_book/features/doctors/presentation/screens/chat_doctor_screen.dart';
import 'package:doctor_book/features/doctors/presentation/screens/home_screen_doctor.dart';
import 'package:doctor_book/features/doctors/presentation/screens/profile_doctor_screen.dart';
import 'package:doctor_book/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:doctor_book/features/forgot_password/presentation/screens/resets_password_screen.dart';
import 'package:doctor_book/features/home/presentation/screens/home_screen.dart';
import 'package:doctor_book/features/info_patient/presentation/screens/info_patient_screen.dart';
import 'package:doctor_book/features/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:doctor_book/features/process_schedule/presentation/screens/confirm_schedule_screen.dart';
import 'package:doctor_book/features/process_schedule/presentation/screens/process_schedule_screen.dart';
import 'package:doctor_book/features/process_schedule/presentation/screens/receive_schedule_screen.dart';
import 'package:doctor_book/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:doctor_book/features/sign_in/presentation/screens/sign_in_screen.dart';
import 'package:doctor_book/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:doctor_book/features/splash/presentation/screens/splash_screen.dart';
import 'package:doctor_book/features/user/presentation/screens/user_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

import '../common/widgets/custom_image_view.dart';
import '../gen/assets.gen.dart';
import 'app_routes.dart';

// Project imports:

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _sellNavigatorKey2 = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/$splash',
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            return SafeArea(child: child);
          },
          routes: [
            GoRoute(
                name: splash,
                path: '/$splash',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return _buildTransition(
                      state: state, screen: const SplashScreen());
                },
                routes: [
                  GoRoute(
                    name: onboarding,
                    path: onboarding,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return _buildTransition(
                          state: state, screen: const OnBoardingScreen());
                    },
                  ),
                  GoRoute(
                      name: signin,
                      path: signin,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return _buildTransition(
                            state: state, screen: const SignInScreen());
                      },
                      routes: [
                        GoRoute(
                            name: signup,
                            path: signup,
                            pageBuilder:
                                (BuildContext context, GoRouterState state) {
                              return _buildTransition(
                                  state: state, screen: const SignUpScreen());
                            },
                            routes: [
                              GoRoute(
                                path: infoPatient,
                                name: infoPatient,
                                pageBuilder: (BuildContext context,
                                    GoRouterState state) {
                                  return _buildTransition(
                                      state: state,
                                      screen: const InfoPatientScreen());
                                },
                              )
                            ]),
                        GoRoute(
                            name: forgotPassword,
                            path: forgotPassword,
                            pageBuilder:
                                (BuildContext context, GoRouterState state) {
                              return _buildTransition(
                                  state: state,
                                  screen: const ForgotPasswordScreen());
                            },
                            routes: [
                              GoRoute(
                                name: resetsPassword,
                                path: resetsPassword,
                                pageBuilder: (BuildContext context,
                                    GoRouterState state) {
                                  final email = state.extra as String;
                                  return _buildTransition(
                                      state: state,
                                      screen: ResetsPasswordScreen(
                                        email: email,
                                      ));
                                },
                              ),
                            ]),
                      ]),
                ]),
            StatefulShellRoute.indexedStack(
                builder: (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return ScaffoldWithNavBar(navigationShell: navigationShell);
                },
                branches: <StatefulShellBranch>[
                  StatefulShellBranch(
                    navigatorKey: _shellNavigatorKey,
                    routes: <RouteBase>[
                      GoRoute(
                        name: home,
                        path: '/$home',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const HomeScreen());
                        },
                        routes: [
                          // GoRoute(
                          //     name: chooseDoctor,
                          //     path: chooseDoctor,
                          //     pageBuilder:
                          //         (BuildContext context, GoRouterState state) {
                          //       return _buildTransitionNoBackground(
                          //           state: state,
                          //           screen: const ChooseDoctorScreen());
                          //     }),
                          GoRoute(
                              name: searchDoctor,
                              path: searchDoctor,
                              pageBuilder:
                                  (BuildContext context, GoRouterState state) {
                                return _buildTransitionNoBackground(
                                    state: state,
                                    screen: const ChooseDoctorScreen());
                              }),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: schedule,
                        path: '/$schedule',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const ScheduleScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: chat,
                        path: '/$chat',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const ChatScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: user,
                        path: '/$user',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const UserScreen());
                        },
                      ),
                    ],
                  ),
                ]),
            GoRoute(
                name: chooseDoctor,
                path: '/$chooseDoctor',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return _buildTransitionNoBackground(
                      state: state, screen: const ChooseDoctorScreen());
                },
                routes: [
                  GoRoute(
                      name: processSchedule,
                      path: processSchedule,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        final doctor = state.extra as Doctor;
                        return _buildTransitionNoBackground(
                            state: state,
                            screen: ProcessScheduleScreen(
                              doctor: doctor,
                            ));
                      },
                      routes: [
                        GoRoute(
                            name: confirmSchedule,
                            path: confirmSchedule,
                            pageBuilder:
                                (BuildContext context, GoRouterState state) {
                              final doctor = state.extra as Doctor;
                              return _buildTransitionNoBackground(
                                  state: state,
                                  screen: ConfirmScheduleScreen(
                                    doctor: doctor,
                                  ));
                            },
                            routes: [
                              GoRoute(
                                name: receiveSchedule,
                                path: receiveSchedule,
                                pageBuilder: (BuildContext context,
                                    GoRouterState state) {
                                  final doctor = state.extra as Doctor;

                                  return _buildTransitionNoBackground(
                                      state: state,
                                      screen: ReceiveScheduleScreen(
                                        doctor: doctor,
                                      ));
                                },
                              ),
                            ]),
                      ]),
                ]),

                   StatefulShellRoute.indexedStack(
                builder: (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return ScaffoldWithNavBar(navigationShell: navigationShell);
                },
                branches: <StatefulShellBranch>[
                  StatefulShellBranch(
                    navigatorKey: _sellNavigatorKey2,
                    routes: <RouteBase>[
                      GoRoute(
                        name: homedoctor,
                        path: '/$homedoctor',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const HomeScreenDoctor());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: appointment,
                        path: '/$appointment',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: AppointmentScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: chatDoctor,
                        path: '/$chatDoctor',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const ChatDoctorScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: profileDoctor,
                        path: '/$profileDoctor',
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          return _buildTransitionNoBackground(
                              state: state, screen: const ProfileDoctorScreen());
                        },
                      ),
                    ],
                  ),
                ]),
          ])
    ]);

CustomTransitionPage<void> _buildTransition(
    {required GoRouterState state, required Widget screen}) {
  return CustomTransitionPage<void>(
    //key: state.pageKey,
    child: screen,
    barrierDismissible: true,
    barrierColor: Colors.black38,
    opaque: false,
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return FadeTransition(
        opacity: animation,
        child: BaseScreen(child: child),
      );
    },
  );
}

CustomTransitionPage<void> _buildTransitionNoBackground(
    {required GoRouterState state, required Widget screen}) {
  return CustomTransitionPage<void>(
    //key: state.pageKey,
    child: screen,
    barrierDismissible: true,
    barrierColor: Colors.black38,
    opaque: false,
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          child,
        ],
      )),
    );
  }
}
