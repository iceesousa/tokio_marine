class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'O e-mail é obrigatório';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome é obrigatório';
    }
    final nameRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor, insira um nome válido (apenas letras e espaços)';
    }
    return null;
  }
  static String? cpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'O CPF é obrigatório';
    }
    final cpfRegex = RegExp(r'^(\d{3}\.\d{3}\.\d{3}-\d{2}|\d{11})$');
    if (!cpfRegex.hasMatch(value)) {
      return 'Por favor, insira um CPF válido';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'A confirmação de senha é obrigatória';
    }
    if (value != password) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }
}
