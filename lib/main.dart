import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/app_color.dart';
import 'consts/constants.dart';
import 'consts/theme_data.dart';
import 'providers/audio_provider.dart';
import 'providers/network_status_service.dart';
import 'providers/settings_provider.dart';
import 'providers/summarizer_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusServiceProvider().networkStatusController.stream,
          initialData:
              NetworkStatus.Online, // Replace with the initial status as needed
        ),
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          //Notify summarized text change
          return SummarizerTextProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return TextToAudioProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return SettingsProvider();
        }),
      ],
      child:
          Consumer<ThemeProvider>(builder: (context, themeChangeProvider, ch) {
        return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            lightColorScheme = lightDynamic.harmonized()..copyWith();
            lightColorScheme =
                lightColorScheme.copyWith(primary: AppColor.lightPrimary);
            darkColorScheme = darkDynamic.harmonized()..copyWith();
            darkColorScheme =
                darkColorScheme.copyWith(primary: AppColor.darkPrimary);
          } else {
            lightColorScheme =
                ColorScheme.fromSeed(seedColor: AppColor.lightPrimary);
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 159, 250),
              brightness: Brightness.dark,
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.appName,
            theme: Styles.themeData(
                isDarkTheme: themeChangeProvider.getIsDarkTheme,
                context: context,
                colorScheme: themeChangeProvider.getIsDarkTheme
                    ? darkColorScheme
                    : lightColorScheme),
            home: const HomeScreen(),
            // routes: appRoutes,
          );
        });
      }),
    );
  }
}
