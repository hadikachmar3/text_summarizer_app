import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/languages_model.dart';
import '../providers/settings_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/gender_widget.dart';
import '../widgets/margins.dart';
import '../widgets/texts/subtitle_text.dart';
import '../widgets/texts/title_text.dart';
import '../widgets/theme_icon.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    final textSummrizerProvidersList =
        settingsProvider.getTextSummarizerProvidersList;

    final voiceProvidersList = settingsProvider.voiceProvidersList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: const [
          ThemeIconWidget(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitlesTextWidget(
                label: "General Settings",
                fontSize: 20,
              ),
              const Vspace(height: 10),
              Card(
                elevation: 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              AssetsManager.conversation,
                              height: 20,
                              width: 20,
                            ),
                            const Wspace(),
                            DropdownButton<String>(
                                elevation: 3,
                                underline: const SizedBox.shrink(),
                                items: languageDropdownItems,
                                hint: TextButton(
                                  child: const Text('Text and Voice Language'),
                                  onPressed: () {},
                                ),
                                value: settingsProvider.getLanguageModel.code,
                                onChanged: (String? newValue) {
                                  settingsProvider.setLanguageModel(
                                    languageName: newValue ?? "English",
                                    languageCode: newValue ?? "en",
                                  );
                                }),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // This was used to prompt you to enter your API KEY
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                AssetsManager.key,
                                height: 20,
                                width: 20,
                              ),
                              const Wspace(),
                              const SubtitlesTextWidget(
                                label: "API KEY",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Vspace(),
              const TitlesTextWidget(
                label: "Text Summarizer Providers",
                fontSize: 20,
              ),
              const Vspace(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Center(
                      child: SizedBox(
                        height: kBottomNavigationBarHeight -
                            10, // Adjust height as needed
                        child: ListView.builder(
                          itemCount: textSummrizerProvidersList
                              .length, // Number of items
                          scrollDirection: Axis
                              .horizontal, // Set scroll direction to horizontal
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Replace this with your state management logic
                                setState(() {
                                  settingsProvider.setTextSummarizerProvider(
                                      provider:
                                          textSummrizerProvidersList[index]);
                                });
                              },
                              child: Card(
                                color: settingsProvider
                                            .getTextSummarizerProvider ==
                                        textSummrizerProvidersList[index]
                                    ? Colors.green
                                    : Theme.of(context).cardColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0), // Adjust padding
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        textSummrizerProvidersList[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Vspace(height: 20),
              const TitlesTextWidget(
                label: "Voice Settings",
                fontSize: 20,
              ),
              const Vspace(),
              const Vspace(),
              Card(
                  elevation: 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SubtitlesTextWidget(
                        //   label: "Please note that you might need to resubmit your text again if you change the voice settings",
                        //   fontSize: 16,
                        // ),
                        const Vspace(),
                        const SubtitlesTextWidget(
                          label: "Voice Providers",
                          fontSize: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Wrap(
                                children: List.generate(
                                    voiceProvidersList.length, (index) {
                                  return FittedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        settingsProvider.setVoiceProvider(
                                          voicePro: voiceProvidersList[index],
                                        );
                                      },
                                      child: Card(
                                        color:
                                            settingsProvider.getVoiceProvider ==
                                                    voiceProvidersList[index]
                                                ? Colors.green
                                                : Theme.of(context).cardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: FittedBox(
                                              child: Text(
                                                voiceProvidersList[index],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const Vspace(
                          height: 6,
                        ),
                        const RadioButtonGroup(),
                        const Vspace(),
                        // Sliders
                        SubtitlesTextWidget(
                          label:
                              "Rate (speed): ${settingsProvider.getVoiceSpeed.toStringAsFixed(0)}",
                          fontSize: 16,
                        ),
                        Slider(
                          min: -100,
                          max: 100,
                          divisions: 200,
                          value: settingsProvider.getVoiceSpeed,
                          onChanged: (value) {
                            settingsProvider.setVoiceSpeed(speed: value);
                          },
                        ),
                        // Pitch
                        SubtitlesTextWidget(
                          label:
                              "Pitch: ${settingsProvider.getVoicePitch.toStringAsFixed(0)}",
                          fontSize: 16,
                        ),
                        Slider(
                          min: -100,
                          max: 100,
                          divisions: 200,
                          value: settingsProvider.getVoicePitch,
                          onChanged: (value) {
                            settingsProvider.setVoicePitch(pitch: value);
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
