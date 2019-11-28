import 'package:equatable/equatable.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';

abstract class PermisosEvent extends Equatable {
  const PermisosEvent();

  @override
  List<Object> get props => [];
}

class LoadPermisos extends PermisosEvent {}

class AddPermiso extends PermisosEvent {
  final PermisoModel permiso;

  const AddPermiso(this.permiso);

  @override
  List<Object> get props => [permiso];

  @override
  String toString() => 'AddPermiso { permiso: $permiso }';
}

class PermisosUpdated extends PermisosEvent {
  final List<PermisoModel> permisos;

  const PermisosUpdated(this.permisos);

  @override
  List<Object> get props => [permisos];
}

class AprobarPermiso extends PermisosEvent {
  final String idPermiso;

  const AprobarPermiso(this.idPermiso);

  @override
  List<Object> get props => [idPermiso];
}

class DenegarPermiso extends PermisosEvent {
  final String idPermiso;

  const DenegarPermiso(this.idPermiso);

  @override
  List<Object> get props => [idPermiso];
}




