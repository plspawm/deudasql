class AuthException {
  final String mensaje;

  const AuthException([this.mensaje = "Un Error ha Ocurrido"]);

  factory AuthException.code(String code) {
    switch(code) {
      case 'wrong-password':
        return const AuthException('Contaseña Erronea');
      case 'invalid-email':
        return const AuthException('Email Invalido');
      case 'user-disabled':
        return const AuthException('Usuario dehabilitado');
      case 'user-not-found':
        return const AuthException('Usuario no encontrado');
      default:
        return const AuthException();
    }
  }
}