import 'package:takemg/models/login.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final DataModel userData;

  UserLoadedState({required this.userData});
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}
