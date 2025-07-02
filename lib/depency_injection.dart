import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tokio_marine/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tokio_marine/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';
import 'package:tokio_marine/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:tokio_marine/features/auth/presentation/bloc/bloc/auth_bloc.dart';

GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  ///USECASES

  getIt.registerFactory(() => RegisterUserUsecase(getIt()));
  getIt.registerFactory(() => SignInUsecase(getIt()));
  getIt.registerFactory(() => SignOutUseCase(getIt()));
  getIt.registerFactory(() => GetCurrentUserUsecase(getIt()));

  ///BLOC
  getIt.registerFactory(
    () => AuthBloc(
      registerUserParams: getIt(),
      registerUserUsecase: getIt(),
      signInParams: getIt(),
      signInUsecase: getIt(),
      signOutUsecase: getIt(),
      getCurrentUserUsecase: getIt(),
    ),
  );

  ///REPOSITORIES
  getIt.registerFactory<IAuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  /// DATASOURCES
  getIt.registerFactory<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      internetConnectionChecker: getIt(),
      firebaseAuth: getIt(),
      firestore: getIt(),
    ),
  );

  ///PARAMS
  getIt.registerFactory(() => const RegisterUserParams(
        email: '',
        password: '',
        cpf: '',
        name: '',
      ));
  getIt.registerFactory(() => const SignInParams(
        cpf: '',
        password: '',
      ));

  ///PACKAGES
  getIt.registerLazySingleton(() => InternetConnection());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
}
