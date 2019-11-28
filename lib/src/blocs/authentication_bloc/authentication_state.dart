import 'package:equatable/equatable.dart';
import 'package:upeupermisos/src/models/persona_model.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final PersonaModel usuario; //TODO El usuario engloba todas sus propiedades (rol, etc)

  const Authenticated(this.usuario);

  @override
  List<Object> get props => [usuario];

  @override
  String toString() => 'Authenticated { usuario: $usuario }';
}

class Unauthenticated extends AuthenticationState {}
