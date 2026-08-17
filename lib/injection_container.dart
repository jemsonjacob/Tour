import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tourexplorer/core/network/dio_client.dart';
import 'package:tourexplorer/core/services/location_service.dart';
import 'package:tourexplorer/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tourexplorer/feature/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/login_usecase.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:tourexplorer/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_bloc.dart';
import 'package:tourexplorer/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:tourexplorer/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:tourexplorer/feature/home/data/repository_impl/home_repository_impl.dart';
import 'package:tourexplorer/feature/home/domain/repositories/home_repository.dart';
import 'package:tourexplorer/feature/home/domain/usecases/home_usecase.dart';
import 'package:tourexplorer/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tourexplorer/feature/saved_places/data/datasource/saved_local_datasource.dart';
import 'package:tourexplorer/feature/saved_places/data/models/saved_place_model.dart';
import 'package:tourexplorer/feature/saved_places/data/repositories/saved_repository_impl.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/get_saved_places_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/is_place_saved_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/remove_place_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/save_place_usecase.dart';
import 'package:tourexplorer/feature/saved_places/presentation/bloc/saved_places/saved_bloc.dart';
import 'package:tourexplorer/feature/saved_places/presentation/cubit/is_place_saved_status_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // dio
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //loaction
  sl.registerLazySingleton<LocationService>(() => LocationService());
  //hive
  sl.registerLazySingleton<Box<SavedPlaceModel>>(
    () => Hive.box<SavedPlaceModel>('saved_places'),
  );
  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatasourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<SavedPlacesLocalDatasource>(
    () => SavedLocalDatasourceImpl(sl<Box<SavedPlaceModel>>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  sl.registerLazySingleton<SavedPlacesRepository>(
    () => SavedPlacesRepositoryImpl(
      localDatasource: sl<SavedPlacesLocalDatasource>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetPlacesUseCase>(
    () => GetPlacesUseCase(sl<HomeRepository>()),
  );
  // Saved Places Use Cases
  sl.registerLazySingleton<SavePlaceUseCase>(
    () => SavePlaceUseCase(sl<SavedPlacesRepository>()),
  );

  sl.registerLazySingleton<RemovePlaceUseCase>(
    () => RemovePlaceUseCase(sl<SavedPlacesRepository>()),
  );

  sl.registerLazySingleton<GetSavedPlacesUseCase>(
    () => GetSavedPlacesUseCase(sl<SavedPlacesRepository>()),
  );

  sl.registerLazySingleton<IsPlaceSavedUseCase>(
    () => IsPlaceSavedUseCase(sl<SavedPlacesRepository>()),
  );

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUseCase: sl<SignUpUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
  //to get fresh bloc
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getPlacesUseCase: sl<GetPlacesUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );

  sl.registerFactory<ExploreBloc>(
    () => ExploreBloc(
      getPlacesUseCase: sl<GetPlacesUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );

  sl.registerFactory<SavedPlaceBloc>(
    () => SavedPlaceBloc(getSavedPlacesUseCase: sl<GetSavedPlacesUseCase>()),
  );
  //cubit

  sl.registerFactory<PlaceSavedStatusCubit>(
    () => PlaceSavedStatusCubit(
      savePlaceUseCase: sl(),
      removePlaceUseCase: sl(),
      isPlaceSavedUseCase: sl(),
    ),
  );
}
