import 'package:app_tareas/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  AuthController(this._repo);

  final AuthRepository _repo;

  Future<String?> login(String email, String password) async {
    try {
      await _repo.signIn(email, password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapErrorCode(e.code);
    }
  }

  String _mapErrorCode(String code) {
    switch (code) {
      case "Invalid-credential":
        return "Usuario o contraseña incorrecta";
      default:
        return "No se puede iniciar sesión {$code}";
    }
  }
}
