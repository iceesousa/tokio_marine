import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tokio_marine/core/exceptions/exceptions.dart';
import 'package:tokio_marine/features/auth/data/models/user_model.dart';

abstract interface class IAuthRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<void> registerUser({
    required String email,
    required String password,
    required String cpf,
    required String name,
  });

  Future<UserModel> signInWithCpfAndPassword({
    required String cpf,
    required String password,
  });

  Future<void> signOut() async {}
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final InternetConnection internetConnectionChecker;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({
    required this.internetConnectionChecker,
    required this.firebaseAuth,
    required this.firestore,
  });
  @override
  Future<void> registerUser({
    required String email,
    required String password,
    required String cpf,
    required String name,
  }) async {
    try {
      if (!await internetConnectionChecker.hasInternetAccess) {
        throw NoInternetConnectionException();
      }
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user == null) {
        throw UserNotFoundException();
      }
      await Future.wait([
        user.updateDisplayName(name),
        firestore.collection('users').doc(user.uid).set({
          'email': email,
          'cpf': cpf,
          'name': name,
        }),
      ]);

      await user.reload();

      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
      );
    } catch (e) {
      throw Exception('Erro ao registrar usuário: $e');
    }
  }

  @override
  Future<UserModel> signInWithCpfAndPassword(
      {required String cpf, required String password}) async {
    try {
      if (!await internetConnectionChecker.hasInternetAccess) {
        throw NoInternetConnectionException();
      }

      //look in firestore for user with email
      final userSnapshot = await firestore
          .collection('users')
          .where('cpf', isEqualTo: cpf)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw UserNotFoundException();
      }

      final userDoc = userSnapshot.docs.first;
      final userModel = UserModel.fromDocumentSnapshot(userDoc);

      await firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (!await internetConnectionChecker.hasInternetAccess) {
        throw NoInternetConnectionException();
      }
      return firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      if (!await internetConnectionChecker.hasInternetAccess) {
        throw NoInternetConnectionException();
      }

      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw UserNotFoundException();
      }

      final userSnapshot = await firestore.collection('users').doc(user.uid).get();

      if (!userSnapshot.exists) {
        throw UserNotFoundException();
      }

      return UserModel.fromDocumentSnapshot(userSnapshot);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
      );
    } catch (e) {
      rethrow;
    }
  }
}
