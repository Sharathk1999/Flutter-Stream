import 'package:flutter_stream/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_stream/core/network/connection_checker.dart';
import 'package:flutter_stream/core/secrets/app_secrets.dart';
import 'package:flutter_stream/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_stream/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_stream/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_stream/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_logout.dart';
import 'package:flutter_stream/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_stream/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_stream/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:flutter_stream/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_stream/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_stream/features/blog/domain/repositories/blog_repository_impl.dart';
import 'package:flutter_stream/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_stream/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_stream/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));

  serviceLocator.registerFactory(() => InternetConnection());

  //core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //useCase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
       
    )
    ..registerFactory(() => UserLogout(serviceLocator(),),)
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //DataSource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImplementation(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplementation(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //UseCases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
