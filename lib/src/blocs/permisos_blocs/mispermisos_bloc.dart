import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upeupermisos/src/repository/permisos_repository.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_event.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_state.dart';

export 'permisos_event.dart';
export 'permisos_state.dart';

class MisPermisosBloc extends Bloc<PermisosEvent, PermisosState> {
  final PermisosRepository _permisosRepository;
  final String _alumnoId;
  StreamSubscription _permisosSubscription;

  MisPermisosBloc({ @required PermisosRepository permisosRepository, @required String alumnoId })
      : assert(permisosRepository != null),
      _permisosRepository = permisosRepository,
      _alumnoId = alumnoId;

  @override
  PermisosState get initialState => PermisosLoading();

  @override
  Stream<PermisosState> mapEventToState( PermisosEvent event ) async* {
    if(event is LoadPermisos) {
      yield* _mapLoadPermisosToState();
    } else if(event is AddPermiso) {
      yield* _mapAddPermisoToState(event);
    } else if(event is PermisosUpdated) {
      yield* _mapPermisosUpdatedToState(event);
    }
  }

  Stream<PermisosState> _mapLoadPermisosToState() async* {
    _permisosSubscription?.cancel();
    _permisosSubscription = _permisosRepository.getMisPermisos(_alumnoId).listen(
      (permisos) => add(PermisosUpdated(permisos)),
    );
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
