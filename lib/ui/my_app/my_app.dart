import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_firebase/ui/screen/main_tap_screen/main_tab_screen_widget.dart';
import 'package:weather_firebase/ui/screen/main_tap_screen/main_tab_screen_widget_model.dart';
import 'package:weather_firebase/ui/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.bgLight,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
      ],
      home: ChangeNotifierProvider(
          create: (_) => MainTabScreenWidgetModel(),
          child: const MainTabScreenWidget()),
    );
  }
}
