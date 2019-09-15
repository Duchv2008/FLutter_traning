import 'dart:async';

class ValidationMixin {
  final emailValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Email not valid");
      }
    }
  );
  
  final passwordValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 4) {
        sink.add(password);
      } else {
        sink.addError("Password is not valid");
      }
    }
  );
}