import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/apis/call.api.dart';
import 'core/consts/const.dart';
import 'core/helpers/helper.dart';
import 'core/routers/router.dart';
import 'core/utils/util.dart';
import 'data/providers/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HSharedPreferences.instance.init();
  await ApiCall.instance.configureDio();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: CApp.appName,
      theme: UTheme.lightTheme,
      darkTheme: UTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
