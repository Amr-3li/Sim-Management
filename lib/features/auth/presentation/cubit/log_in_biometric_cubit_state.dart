part of 'log_in_biometric_cubit_cubit.dart';

@immutable
sealed class LogInBiometricCubitState {}

final class LogInBiometricCubitInitial extends LogInBiometricCubitState {}

final class LogInBiometricCubitLoading extends LogInBiometricCubitState {}

final class LogInBiometricCubitSuccess extends LogInBiometricCubitState {
  final Biometric biometric;
  LogInBiometricCubitSuccess({required this.biometric});
}

final class LogInBiometricCubitError extends LogInBiometricCubitState {
  final String message;
  LogInBiometricCubitError({required this.message});
}
