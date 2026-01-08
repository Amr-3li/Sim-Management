import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/di/get_it.dart';
import 'package:sim_management_task/features/auth/domain/use_case/log_in_biometric_use_case.dart';
import 'package:sim_management_task/features/auth/presentation/cubit/log_in_biometric_cubit_cubit.dart';
import 'package:sim_management_task/features/auth/presentation/views/page/agent_login_page.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/get_sim_data_use_case.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/listen_sim_changes.dart';
import 'package:sim_management_task/features/sim_management/presentation/cubits/get_sim_data/get_sim_data_cubit.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sim_management_page.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sync_sms_page.dart';
import 'package:sim_management_task/features/splash_screan/splash_screan.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScrean()),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) => LogInBiometricCubitCubit(
            logInBiometricUseCase: getIt<LogInBiometricUseCase>(),
          ),
          child: const AgentLoginPage(),
        ),
      ),
      GoRoute(
        path: SimManagementPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => GetSimDataCubit(
            getIt<GetSimDataUseCase>(),
            listenSimChanges: getIt<ListenSimChanges>(),
          ),
          child: const SimManagementPage(),
        ),
      ),
      GoRoute(
        path: SyncSmsPage.routeName,
        builder: (context, state) =>
            SyncSmsPage(simName: "SIM ${state.extra.toString()}"),
      ),
    ],
  );
}
