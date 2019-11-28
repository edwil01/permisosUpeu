import 'dart:async';



class Validators {


  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {


      // Pattern pattern = r'^(0|[1-9][0-9]*)$';
      // RegExp regExp   = new RegExp(pattern);

      // if ( regExp.hasMatch( email ) ) {
      //   sink.add( email );
      // } else {
      //   sink.addError('codigo no es correcto');
      // }
      sink.add(email);

    }
  );


  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >=4 ) {
        sink.add( password );
      } else {
        sink.addError('Más de 4 caracteres por favor');
      }

    }
  );


}
