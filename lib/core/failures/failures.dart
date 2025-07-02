class Failure {
  final String message;

  Failure(this.message);
}

final class ServerFailure extends Failure {
  ServerFailure(super.message);
}

final class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure()
      : super(
            'Sem conexão com a internet. Por favor, verifique sua conexão e tente novamente.');
}

final class UserNotFoundFailure extends Failure {
  UserNotFoundFailure()
      : super('Usuário não encontrado. Por favor, verifique suas credenciais.');
}
final class SignInWithEmailAndPasswordFailure extends Failure {
  SignInWithEmailAndPasswordFailure(super.message);

  /// Cria uma instância de [SignInWithEmailAndPasswordFailure] a partir de um código de erro do Firebase.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return SignInWithEmailAndPasswordFailure(
          'O e-mail fornecido não é válido. Por favor, verifique e tente novamente.',
        );
      case 'user-disabled':
        return SignInWithEmailAndPasswordFailure(
          'Este usuário foi desativado. Por favor, entre em contato com o suporte.',
        );
      case 'user-not-found':
        return SignInWithEmailAndPasswordFailure(
          'Nenhum usuário encontrado com este e-mail. Verifique suas credenciais.',
        );
      case 'wrong-password':
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return SignInWithEmailAndPasswordFailure(
          'A senha está incorreta. Por favor, tente novamente.',
        );
      case 'too-many-requests':
        return SignInWithEmailAndPasswordFailure(
          'Muitas tentativas de login. Por favor, aguarde e tente novamente mais tarde.',
        );
      case 'user-token-expired':
        return SignInWithEmailAndPasswordFailure(
          'Sua sessão expirou. Por favor, faça o login novamente.',
        );
      case 'network-request-failed':
        return SignInWithEmailAndPasswordFailure(
          'Erro de conexão com a rede. Verifique sua internet e tente novamente.',
        );
      case 'operation-not-allowed':
        return SignInWithEmailAndPasswordFailure(
          'O login com e-mail e senha não está habilitado. Entre em contato com o suporte.',
        );
      default:
        return SignInWithEmailAndPasswordFailure(
          'Ocorreu um erro inesperado. Por favor, tente novamente.',
        );
    }
  }
}
  
// Falha que lida com os erros do método `createUserWithEmailAndPassword`.
final class CreateUserWithEmailAndPasswordFailure extends Failure {
  CreateUserWithEmailAndPasswordFailure(super.message);

  /// Cria uma instância de [CreateUserWithEmailAndPasswordFailure] a partir de um código de erro do Firebase.
  factory CreateUserWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return CreateUserWithEmailAndPasswordFailure(
          'Este e-mail já está em uso. Por favor, tente fazer login ou use outro e-mail.',
        );
      case 'invalid-email':
        return CreateUserWithEmailAndPasswordFailure(
          'O e-mail fornecido não é válido. Por favor, verifique o formato.',
        );
      case 'operation-not-allowed':
        return CreateUserWithEmailAndPasswordFailure(
          'A criação de contas com e-mail e senha não está habilitada no momento.',
        );
      case 'weak-password':
        return CreateUserWithEmailAndPasswordFailure(
          'A senha é muito fraca. Tente uma senha mais forte com mais caracteres ou símbolos.',
        );
      case 'too-many-requests':
        return CreateUserWithEmailAndPasswordFailure(
          'Muitas solicitações de cadastro foram enviadas. Por favor, aguarde e tente novamente mais tarde.',
        );
      case 'user-token-expired':
        return CreateUserWithEmailAndPasswordFailure(
          'Sua sessão de autenticação expirou. Por favor, tente o cadastro novamente.',
        );
      case 'network-request-failed':
        return CreateUserWithEmailAndPasswordFailure(
          'Erro de conexão. Verifique sua internet e tente cadastrar-se novamente.',
        );
      default:
        return CreateUserWithEmailAndPasswordFailure(
          'Ocorreu um erro inesperado durante o cadastro. Por favor, tente novamente.',
        );
    }
  }
}
