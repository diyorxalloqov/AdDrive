import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:addrive/firebase_options.dart';
import 'package:addrive/hive/hive_fav_provider.dart';
import 'package:addrive/hive/hive_location_provider.dart';
import 'package:addrive/language/app_language.dart';
import 'package:addrive/model/driver_location_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:addrive/model/hive_model/fav/favourite_car_model.dart';
import 'package:addrive/model/hive_model/user_model.dart';
import 'package:addrive/routes/app_pages.dart';
import 'package:addrive/routes/app_routes.dart';
import 'package:addrive/screens/add_vehicle/bloc/car_bloc.dart';
import 'package:addrive/screens/add_vehicle/db/car_db.dart';
import 'package:addrive/screens/main_screen/cubit/location_cubit.dart';
import 'package:addrive/services/firebase_location_service.dart';
import 'package:addrive/services/geolocator_service.dart';
import 'package:addrive/utils/custom_error_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'app_config/common_method.dart';
import 'app_theme/theme.dart';
import 'bindings/initial_binding.dart';
import 'controller/auth_controller.dart';
import 'data/local_data/shared_preference.dart';

///Initialize  Hive local database
Future openBox() async {
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(DriverLocationModelAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FavoriteCarAdapter());
  await Hive.openBox<DriverLocationModel>(location);
  await Hive.openBox<User>(userBoxName);
  await Hive.openBox<FavoriteCar>(favBoxName);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await openBox();
  CarDb.registerAdapters();
  final languageCode = await getLocalData(key: 'languageCode');
  FlutterNativeSplash.remove();

  ///device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(languageCode));
}

class MyApp extends StatelessWidget {
  final String? languageCode;
  MyApp(this.languageCode, {super.key});

  final geoService = GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => CarBloc()),
      ],
      child: MultiProvider(
        providers: [
          FutureProvider<BitmapDescriptor?>(
            create: (context) => Common.setCustomMapPin('asset/car-ash.png'),
            initialData: null,
          ),
          Provider(create: (context) => FirebaseLocationService()),
          ChangeNotifierProvider<FavService>(create: (context) => FavService()),
        ],
        child: ScreenUtilInit(
          builder: (_, __) {
            return AdaptiveTheme(
                initial: AdaptiveThemeMode.light,
                light: AppTheme().lightTheme,
                dark: AppTheme().darkTheme,
                debugShowFloatingThemeButton: kDebugMode,
                builder: (theme, darkTheme) {
                  return GetMaterialApp(
                    builder: (context, child) {
                      ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                        return CustomErrorWidget(errorDetails: errorDetails);
                      };
                      return child!;
                    },
                    debugShowCheckedModeBanner: false,
                    initialRoute: AppRoutes.splashScreen,
                    getPages: AppPages.list,
                    title: 'AdDrive',
                    theme: theme,
                    darkTheme: darkTheme,
                    themeMode: ThemeMode.system,
                    translations: AppLanguage(),
                    locale: Locale(languageCode ?? 'uz'),
                    initialBinding: InitialBinding(),
                  );
                });
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
