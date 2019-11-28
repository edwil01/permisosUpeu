import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upeupermisos/src/repository/permisos_repository.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_event.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_state.dart';

export 'permisos_event.dart';
export 'permisos_state.dart';

class PermisosBloc extends Bloc<PermisosEvent, PermisosState> {
  final PermisosRepository _permisosRepository;
  StreamSubscription _permisosSubscription;

  PermisosBloc({ @required PermisosRepository permisosRepository})
      : assert(permisosRepository != null),
      _permisosRepository = permisosRepository;

  @override
  PermisosState get initialState => PermisosLoading();

  @override
  Stream<PermisosState> mapEventToState( PermisosEvent event ) async* {
    if(event is LoadPermisos) {
      yield* _mapLoadPermisosToState();
    } else if(event is AddPermiso) {
      yield* _mapAddPermisoToState(event);
    } else if(event is AprobarPermiso) {
      yield* _mapAprobarPermisoToState(event);
    } else if(event is DenegarPermiso) {
      yield* _mapDenegarPermisoToState(event);
    } else if(event is PermisosUpdated) {
      yield* _mapPermisosUpdatedToState(event);
    }
  }

  Stream<PermisosState> _mapLoadPermisosToState() async* {
    _permisosSubscription?.cancel();
    _permisosSubscription = _permisosRepository.getTodosPermisos().listen(
      (permisos) => add(PermisosUpdated(permisos)),
    );
  }

  Stream<PermisosState> _mapAprobarPermisoToState(AprobarPermiso event) async* {
    _permisosRepository.actualizarEstado(event.idPermiso, 'aprobado');
  }

  Stream<PermisosState> _mapDenegarPermisoToState(DenegarPermiso event) async* {
    _permisosRepository.actualizarEstado(event.idPermiso, 'denegado');
  }

  Stream<PermisosState> _mapAddPermisoToState(AddPermiso event) async* {
    _permisosRepository.addNewPermiso(event.permiso);
  }

  Stream<PermisosState> _mapPermisosUpdatedToState(PermisosUpdated event) async* {
    yield PermisosLoaded(event.permisos);
  }

  @override
  Future<void> close() {
    _permisosSubscription?.cancel();
    return super.close();
  }
}
