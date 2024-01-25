import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import 'texts/subtitle_text.dart';

class RadioButtonGroup extends StatefulWidget {
  const RadioButtonGroup({super.key});

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: SubtitlesTextWidget(
            label: "Reader Gender Voice",
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Card(
            elevation: 0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: settingsProvider.genderLabels.map((label) {
                    return Row(
                      children: [
                        Text(label),
                        Radio(
                          value: label,
                          groupValue: settingsProvider.getSelectedGenderLabel,
                          onChanged: (value) {
                            settingsProvider.setSelectedGenderLabel(
                                gender: value!);
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
