import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
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
import 'package:tourexplorer/feature/place_details/data/datasource/place_details_remote_datasource.dart';
import 'package:tourexplorer/feature/place_details/data/datasource/place_details_remote_datasource_impl.dart';
import 'package:tourexplorer/feature/place_details/data/repository_impl/place_details_repository_impl.dart';
import 'package:tourexplorer/feature/place_details/domain/repository/place_details_repository.dart';
import 'package:tourexplorer/feature/place_details/domain/usecases/get_place_details_usecase.dart';
import 'package:tourexplorer/feature/place_details/presentation/bloc/place_details_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // dio
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //loaction
  sl.registerLazySingleton<LocationService>(() => LocationService());

  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatasourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<PlaceDetailsRemoteDataSource>(
    () => PlaceDetailsRemoteDatasourceImpl(dio: sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  sl.registerLazySingleton<PlaceDetailsRepository>(
    () => PlaceDetailsRepositoryImpl(sl<PlaceDetailsRemoteDataSource>()),
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

  sl.registerLazySingleton<GetPlaceDetailsUsecase>(
    () => GetPlaceDetailsUsecase(sl<PlaceDetailsRepository>()),
  );
  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUseCase: sl<SignUpUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );
  //to get fresh bloc
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getPlacesUseCase: sl<GetPlacesUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );

  sl.registerFactory<PlaceDetailsBloc>(
    () =>
        PlaceDetailsBloc(getPlaceDetailsUsecase: sl<GetPlaceDetailsUsecase>()),
  );

  sl.registerFactory<ExploreBloc>(
    () => ExploreBloc(
      getPlacesUseCase: sl<GetPlacesUseCase>(),
      locationService: sl<LocationService>(),
    ),
  );
}
