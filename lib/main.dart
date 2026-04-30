import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pedal/common/theme/app_theme.dart';
import 'package:pedal/core/di/app_di.dart';
import 'package:pedal/core/routes/app_router.dart';
import 'package:pedal/services/fcm/fcm_service.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY']!,
      appId: dotenv.env['FIREBASE_ANDROID_APP_ID']!,
      messagingSenderId: dotenv.env['FIREBASE_ANDROID_MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['FIREBASE_ANDROID_PROJECT_ID']!,
      storageBucket: dotenv.env['FIREBASE_ANDROID_STORAGE_BUCKET']!,
    ),
  );

  await FcmService().initialize();

  await FlutterNaverMap().init(
    clientId: dotenv.env['NAVER_CLIENT_ID']!,
    onAuthFailed: (ex) => debugPrint('Naver Map 인증 실패: $ex'),
  );

  // Google Sign-In SDK 초기화
  await GoogleSignIn.instance.initialize(
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
    serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
  );

  // Kakao SDK 초기화
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']!);

  final di = await AppDI.setup();
  runApp(
    MultiProvider(
      providers: di.providers,
      child: PedalApp(di: di),
    ),
  );
}

class PedalApp extends StatelessWidget {
  final AppDI di;

  const PedalApp({super.key, required this.di});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Pedal',
        theme: AppTheme.light,
        routerConfig: AppRouter.createRouter(di.authViewModel),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
