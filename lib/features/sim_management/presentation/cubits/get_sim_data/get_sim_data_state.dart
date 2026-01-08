part of 'get_sim_data_cubit.dart';

@immutable
sealed class GetSimDataState {}

final class GetSimDataInitial extends GetSimDataState {}

final class GetSimDataLoading extends GetSimDataState {}

final class GetSimDataSuccess extends GetSimDataState {
  final List<SimModel> sims;
  GetSimDataSuccess({required this.sims});
}

final class GetSimDataFailure extends GetSimDataState {
  final Failure failure;
  GetSimDataFailure({required this.failure});
}
