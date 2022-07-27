import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_service.dart';
import 'cubits/bloc_observer.dart';
import 'constants/components/components.dart';
import 'constants/constants.dart';
import 'cubits/app_cubit/cubit.dart';
import 'cubits/app_cubit/states.dart';
import 'cubits/cubit/cubit.dart';
import 'network/local/cache_helper.dart';
import 'styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('on background message');
  }
  if (kDebugMode) {
    print(message.data.toString());
  }

  showToast(
    text: 'on background message',
    state: ToastStates.success,
  );
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  bool ?isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}
class MyApp extends StatelessWidget {
  final bool ?isDark;
  const MyApp({
    this.isDark,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(
                // fromShared: isDark!,
              ),
          ),
          BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark!
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: AuthService().handleAuthState(),
            );
          },
        ));
  }
}