import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../screens/settings_screen.dart';
import 'app_name_text.dart';
import 'margins.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final textToAudioProvider = Provider.of<TextToAudioProvider>(context);
    return AppBar(
      title: const AppNameTextWidget(
        fontSize: 18,
      ),
      actions: [
        PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {},
              value: 1,
              child: const Row(
                children: [
                  Icon(Icons.info_outline),
                  Wspace(),
                  Text("Developer"),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              // padding: EdgeInsets.all(3),
              onTap: () {
                textToAudioProvider.clearTextToVoiceModel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.settings_outlined),
                  Wspace(),
                  Text("Settings"),
                ],
              ),
            ),
            // PopupMenuItem(
            //     value: 2,
            //     // padding: EdgeInsets.all(3),
            //     onTap: () {
            //       themeProvider.setDarkTheme(!themeProvider.getIsDarkTheme);
            //     },
            //     child: Row(
            //       children: [
            //         Icon(themeProvider.getIsDarkTheme
            //             ? Icons.light_mode
            //             : Icons.dark_mode),
            //         Wspace(),
            //         Text(themeProvider.getIsDarkTheme
            //             ? "Dark Theme"
            //             : "Light Theme"),
            //       ],
            //     )),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
