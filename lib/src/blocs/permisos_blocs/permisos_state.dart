import 'package:equatable/equatable.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';

abstract class PermisosState extends Equatable {
  const PermisosState();

  @override
  List<Object> get props => [];
}

class PermisosLoading extends PermisosState {}

class PermisosLoaded extends PermisosState {
  final List<PermisoModel> permisos;

  const PermisosLoaded(this.permisos);

  @override
  List<Object> get props => [permisos];

  @override
  String toString() => 'PermisosLoaded { todos: $permisos }';
}

// class PermisosNotLoaded extends PermisosState {}
