import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sehetak2/components/applocal.dart';
import 'package:sehetak2/consts/theme_data.dart';
import 'package:sehetak2/inner_screens/product_details.dart';
import 'package:sehetak2/network/remote/dio_notification.dart';
import 'package:sehetak2/screens/chat/VIews/ChatScreen.dart';
import 'package:sehetak2/screens/chat/VIews/recent_chat.dart';
import 'package:sehetak2/screens/medicine-remminder/screens/home/home.dart';
import 'package:sehetak2/screens/splash-Screen/splash-s.dart';
import 'package:sehetak2/screens/upload_product_form.dart';
import 'package:sehetak2/provider/dark_theme_provider.dart';
import 'package:sehetak2/provider/products.dart';
import 'package:sehetak2/screens/user_state.dart';
import 'package:sehetak2/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'network/remote/dio_token_getter.dart';
import 'provider/cart_provider.dart';
import 'provider/favs_provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';
import 'screens/bottom_bar.dart';
import 'screens/cart.dart';
import 'screens/feeds.dart';
import 'screens/landing_page.dart';
import 'screens/medicine-remminder/screens/add_new_medicine/add_new_medicine.dart';

SharedPreferences mySharedPreferences;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  DioHelper.init();
  DioNotificationHelper.init();
  DioTokenGetter.init();
  DioTokenGetter.getToken();
  CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool fromNotification =false;
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  String notName,notUrl,notUid,notDid,notToken;

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  initalMessage() async{
    var event = await FirebaseMessaging.instance.getInitialMessage();
    if(event != null)
    {
      Navigator.of(context).pushNamed("/recent_chat");
    }
  }
  @override
  void initState() {
    initalMessage();
    getCurrentAppTheme();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavsProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: const splashpage(),
                  //initialRoute: '/',
                  routes: {
                    "/home": (context) => HomeReminder(),
                    "/add_new_medicine": (context) => AddNewMedicine(),
                    "/recent_chat" : (context) => RecentChats(),
                    //   '/': (ctx) => LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    Feeds.routeName: (ctx) => Feeds(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                  },

                  localizationsDelegates: [
                    AppLocale.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: [
                    Locale("en", ""),
                    Locale("ar", ""),
                  ],

                  localeResolutionCallback: (currentLang, supportLang) {
                    if (currentLang != null) {
                      for (Locale locale in supportLang) {
                        if (locale.languageCode == currentLang.languageCode) {
                          // mySharedPreferences.setString(
                          //     "lang", currentLang.languageCode);
                          return currentLang;
                        }
                      }
                    }
                    return supportLang.first;
                  },
                );
              }));
        });
  }
}
