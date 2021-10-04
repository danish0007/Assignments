import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:sizer/sizer.dart';
import 'package:stockdaddy/repository/sd_default_model_repo.dart';
import 'package:stockdaddy/screens/screens.dart';
import 'package:stockdaddy/screens/sd_home_screen.dart';
import 'package:stockdaddy/screens/sd_splash_screen.dart';
import 'package:stockdaddy/utils/sd_bloc_observer.dart';
import 'controllers/controller.dart';
import 'utils/sd_logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';

Future<void> main() async {
  SDLogging.setup(logTo: SDLogType.console, level: Level.ALL);
  Bloc.observer = SDBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SDLogging.setup(logTo: SDLogType.console, level: Level.ALL);
  HydratedBloc.storage = await HydratedStorage.build(
    encryptionCipher: HydratedAesCipher(sha256
        .convert(
          utf8.encode('ginee'),
        )
        .bytes),
    storageDirectory: await getTemporaryDirectory(),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Restrict The App to be used in only Portrait Mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SDFirebaseDefaultRepo(path: 'diary'),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SDTaskCubit(
              repo: SDFirebaseDefaultRepo(path: 'diary'),
            ),
          ),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                SDSplashScreen.id: (context) => const SDSplashScreen(),
                SDIntroScreen.id: (context) => const SDIntroScreen(),
                SDHomeScreen.id: (context) => const SDHomeScreen(),
                SDEditCreateScreen.id: (context) => const SDEditCreateScreen(),
              },
              home: FutureBuilder(
                future: Future.delayed(
                  const Duration(milliseconds: 2000),
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SDSplashScreen();
                  }
                  return const SDHomeScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
