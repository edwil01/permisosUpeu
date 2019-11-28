import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/repository/persona_repository.dart';
import 'package:upeupermisos/src/repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final PersonaRepository _personaRepository;

  AuthenticationBloc({@required UserRepository userRepository, @required PersonaRepository personaRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _personaRepository = personaRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event.email, event.password);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {

        //TODO Si el usuario está autenticado, se obtiene sus datos
        final userId = await _userRepository.getUserId();
        final user = await _personaRepository.getPersonaById(userId);

        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState( String email, String password ) async* {
    try {
      await _userRepository.signInWithCredentials(email, password);
      
      //TODO Cuando se autentica el usuario, se obtiene sus datos
      final userId = await _userRepository.getUserId();
      final user = await _personaRepository.getPersonaById(userId);

      yield Authenticated(user);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
