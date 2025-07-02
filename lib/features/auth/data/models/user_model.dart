import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.cpf,
    required super.name,
    required super.id,
  });

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> userDoc) {
    final userDocData = userDoc.data();
    if (userDocData == null) {
      throw Exception('User document data is null');
    }
    return UserModel(
      email: userDocData['email'] as String,
      cpf: userDocData['cpf'] as String,
      name: userDocData['name'] as String,
      id: userDoc.id,
    );
  }
}
