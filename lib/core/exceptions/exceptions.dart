class NoInternetConnectionException implements Exception {
  final String message;

  NoInternetConnectionException(
      {this.message =
          'Sem conexão com a internet. Por favor, verifique sua conexão e tente novamente.'});

  @override
  String toString() => message;
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException({this.message = 'Usuário não encontrado.'});

  @override
  String toString() => message;
}
