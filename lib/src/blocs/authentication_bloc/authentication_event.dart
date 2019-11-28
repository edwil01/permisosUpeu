import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String password;
  final String email;

  LoggedIn(this.email, this.password);
}

class LoggedOut extends AuthenticationEvent {}


