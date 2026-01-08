import 'package:get_it/get_it.dart';
import 'package:sim_management_task/features/auth/data/data_source/log_in_with_biometric.dart';
import 'package:sim_management_task/features/auth/data/data_source/log_in_with_biometric_impl.dart';
import 'package:sim_management_task/features/auth/data/rebo/log_in_biometric_rebo_imbl.dart';
import 'package:sim_management_task/features/auth/domain/rebo/log_in_biometric_rebo.dart';
import 'package:sim_management_task/features/auth/domain/use_case/log_in_biometric_use_case.dart';
import 'package:sim_management_task/features/auth/presentation/cubit/log_in_biometric_cubit_cubit.dart';
import 'package:sim_management_task/features/sim_management/data/data_source/get_sims_data.dart';
import 'package:sim_management_task/features/sim_management/data/data_source/get_sims_data_impl.dart';
import 'package:sim_management_task/features/sim_management/data/repo/get_sim_data_repo_impl.dart';
import 'package:sim_management_task/features/sim_management/domain/repo/get_sim_data_repo.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/get_sim_data_use_case.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/listen_sim_changes.dart';
import 'package:sim_management_task/features/sim_management/presentation/cubits/get_sim_data/get_sim_data_cubit.dart';

final getIt = GetIt.instance;

Future<void> GetItSetup() async {
  // Auth with biometric
  getIt.registerLazySingleton<LogInWithBiometric>(
    () => LogInWithBiometricImpl(),
  );
  getIt.registerLazySingleton<LogInBiometricRebo>(
    () =>
        LogInBiometricReboImbl(logInWithBiometric: getIt<LogInWithBiometric>()),
  );
  getIt.registerLazySingleton<LogInBiometricUseCase>(
    () =>
        LogInBiometricUseCase(logInBiometricRebo: getIt<LogInBiometricRebo>()),
  );
  getIt.registerLazySingleton<LogInBiometricCubitCubit>(
    () => LogInBiometricCubitCubit(
      logInBiometricUseCase: getIt<LogInBiometricUseCase>(),
    ),
  );

  // Sim data
  getIt.registerLazySingleton<GetSimsData>(() => GetSimsDataImpl());
  getIt.registerLazySingleton<GetSimDataRepo>(
    () => GetSimDataRepoImpl(getIt<GetSimsData>()),
  );
  getIt.registerLazySingleton<GetSimDataUseCase>(
    () => GetSimDataUseCase(getIt<GetSimDataRepo>()),
  );
  getIt.registerLazySingleton<ListenSimChanges>(() => ListenSimChanges());
  getIt.registerLazySingleton<GetSimDataCubit>(
    () => GetSimDataCubit(
      getIt<GetSimDataUseCase>(),
      listenSimChanges: getIt<ListenSimChanges>(),
    ),
  );
}
