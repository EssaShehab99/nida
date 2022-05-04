import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/constants/constants_values.dart';
import '/data/providers/app_state_manager.dart';
import '/data/providers/connect_us_manager.dart';
import '/data/providers/post_manager.dart';
import '/styles/theme.dart';
import 'package:provider/provider.dart';

import 'data/network/help_dao.dart';
import 'data/network/post_dao.dart';
import 'data/network/token_dao.dart';
import 'data/providers/home_manager.dart';
import 'modules/navigation/app_route.dart';
import 'modules/navigation/app_route_parser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'YE')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('ar', 'YE'),
      saveLocale: false,
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager()..initial();
  final _homeManager = HomeManager();
  final _detailsManager = PostManager();
  final _connectUsManager = ConnectUsManager();
  final routeParser = AppRouteParser();
  late AppRoute _appRoute;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _appRoute = AppRoute(
        appStateManager: _appStateManager,
        homeManager: _homeManager,
        postManager: _detailsManager,
        connectUsManager: _connectUsManager);
    super.initState();
    initPlatformState();
  }
  static final String oneSignalAppId = "12205d7a-4f7a-48b0-a44c-ade73e73a3a5";
  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared.sendTag("key", "value");

    OneSignal.shared.sendTag("key", "value").then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");

    });
  }

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('ar', 'YE'));
    ConstantsValue(context);

    setToken(BuildContext context) async {
      try {
        final status = await OneSignal.shared.getDeviceState();
        String? osUserID = status?.userId;
        final provider = Provider.of<TokenDao>(context, listen: false);
        if (osUserID != null) {
          provider.isExist(osUserID).then((value) {
            if (!value) {
              Provider.of<AppStateManager>(context, listen: false).setToken(osUserID);
              provider.saveToken(osUserID);
            }
          });
        }
      } catch (e) {}
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager),
        ChangeNotifierProvider(create: (context) => _homeManager),
        ChangeNotifierProvider(create: (context) => _detailsManager),
        ChangeNotifierProvider(create: (context) => _connectUsManager),
        ChangeNotifierProvider(create: (context) => PostDao()),
        ChangeNotifierProvider(create: (context) => HelpDao()),
        ChangeNotifierProvider(create: (context) => TokenDao()),
      ],
      child: Consumer<AppStateManager>(builder: (context, value, child) {
        value.initial().whenComplete(() {
          if (value.token == null) {
            setToken(context);
          }
        });
        return MaterialApp.router(
          title: 'Nida App',
          routeInformationParser: routeParser,
          routerDelegate: _appRoute,
          backButtonDispatcher: RootBackButtonDispatcher(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          themeMode: ThemeMode.light,
        );
      }),
    );
  }
}
