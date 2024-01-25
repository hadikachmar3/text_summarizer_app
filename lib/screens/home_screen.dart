import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../consts/constants.dart';
import '../consts/validators.dart';
import '../loading_manager.dart';
import '../providers/audio_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/summarizer_provider.dart';
import '../widgets/main_appbar.dart';
import '../widgets/network_checker_widget.dart';
import '../widgets/texts/subtitle_text.dart';
import '../widgets/texts/title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _textController;
  int _summarySentenceCount = 3; // Initialized to 3
  bool _copySuccessful = false;

  final outputText = GlobalKey();
  late AudioPlayer _audioPlayer;
  bool _isVoiceLoading = false;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    //audio player
    _audioPlayer = AudioPlayer();
    _textController.addListener(() {
      setState(
        () {},
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void clearForm() {
    _textController.clear();
  }

  bool _isLoading = false;
  bool _isPlayingText = false;
  @override
  Widget build(BuildContext context) {
    final summarizerTextProvider = Provider.of<SummarizerTextProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final textToAudioProvider = Provider.of<TextToAudioProvider>(context);

    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: const MainAppbar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NetworkCheckerWidget(),
                const SizedBox(
                  height: 10,
                ),
                const TitlesTextWidget(
                  label: "Desired output sentences:",
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: kBottomNavigationBarHeight - 10,
                  child: ListView.builder(
                    itemCount: Constants.numberOfMaxSentences,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          _summarySentenceCount = index + 1;
                        }),
                        child: Card(
                          color: _summarySentenceCount == index + 1
                              ? Colors.green
                              : Theme.of(context).cardColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  '${index + 1}',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Not really needed a form - but keep it. To be excluded during the explanation
                Form(
                  key: _formKey,
                  child: TextFormField(
                    key: const ValueKey('Description'),
                    controller: _textController,
                    minLines: 6,
                    maxLines: 18,
                    maxLength: 2400,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Your text to be summarized',
                    ),
                    validator: (value) {
                      return MyValidators.textValidator(
                          value: value,
                          toBeReturnedString: "Description is missed");
                    },

                    // onChanged: (v) {
                    //   if (v.length == 1 || v.isEmpty) {
                    //     setState(() {});
                    //   }
                    // },
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: _textController.text.isEmpty
                        ? null
                        : () async {
                            await summarizeText(
                              summarizerTextProvider: summarizerTextProvider,
                              textToAudioProvider: textToAudioProvider,
                              settingsProvider: settingsProvider,
                            );
                          },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          summarizerTextProvider.getError == null &&
                                  summarizerTextProvider
                                          .getSummarizerTextModel !=
                                      null
                              ? "Re-Submit"
                              : "Submit",
                        ),
                        const SizedBox.square(dimension: 4),
                        const Icon(
                          IconlyLight.send,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                summarizerTextProvider.getError != null
                    ? Center(
                        child: SubtitlesTextWidget(
                          label:
                              "An error has been occured\n${summarizerTextProvider.getError!}",
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink(),
                Visibility(
                  visible: summarizerTextProvider.getError == null &&
                      summarizerTextProvider.getSummarizerTextModel == null,
                  child: const TitlesTextWidget(
                    maxLines: 2,
                    label: "Output text will be displayed below",
                    fontSize: 18,
                  ),
                ),

                Visibility(
                  visible: summarizerTextProvider.getError == null &&
                      summarizerTextProvider.getSummarizerTextModel != null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .cardColor, //Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  flex: 3,
                                  child: TitlesTextWidget(
                                    maxLines: 3,
                                    label: "Summarized text ",
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Spacer(),
                                Material(
                                  borderRadius: BorderRadius.circular(18),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _isVoiceLoading
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child:
                                                      CircularProgressIndicator()),
                                            )
                                          : IconButton(
                                              iconSize: 20,
                                              onPressed: () async {
                                                await playVoice(
                                                  summarizerTextProvider:
                                                      summarizerTextProvider,
                                                  textToAudioProvider:
                                                      textToAudioProvider,
                                                  settingsProvider:
                                                      settingsProvider,
                                                );
                                              },
                                              icon: Icon(
                                                _isPlayingText
                                                    ? Icons.stop
                                                    : Icons.volume_up_rounded,
                                                color: _isPlayingText
                                                    ? Colors.red
                                                    : Colors.blue,
                                              ),
                                            ),
                                      IconButton(
                                        iconSize: 20,
                                        onPressed: () async {
                                          await Share.share(
                                            summarizerTextProvider
                                                .getSummarizerTextModel!.result,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        onPressed: () async {
                                          await copyFCT(summarizerTextProvider);
                                        },
                                        icon: Icon(
                                          _copySuccessful
                                              ? Icons.done_all
                                              : Icons.copy,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            key: outputText,
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              summarizerTextProvider
                                      .getSummarizerTextModel?.result ??
                                  "",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playVoice({
    required SummarizerTextProvider summarizerTextProvider,
    required TextToAudioProvider textToAudioProvider,
    required SettingsProvider settingsProvider,
  }) async {
    if (_isPlayingText) {
      await _audioPlayer.stop();
      setState(() {
        _isPlayingText = false;
      });
    } else {
      try {
        if (textToAudioProvider.getTextToAudioModel == null) {
          setState(() {
            _isVoiceLoading = true;
          });
          await textToAudioProvider.textToVoiceFCT(
            text: summarizerTextProvider.getSummarizerTextModel!.result,
            provider: settingsProvider.getVoiceProvider,
            option: settingsProvider.getSelectedGenderLabel,
            rate: int.parse(settingsProvider.getVoicePitch.toStringAsFixed(0)),
            pitch: int.parse(settingsProvider.getVoicePitch.toStringAsFixed(0)),
          );
        }

        setState(() {
          _isPlayingText = true;
        });
        await _audioPlayer.play(
          UrlSource(textToAudioProvider.getTextToAudioModel!.audioResourceUrl),
        );
      } catch (error) {
        final snackBar = SnackBar(
          content: Text(error.toString()),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } finally {
        setState(() {
          _isVoiceLoading = false;
        });
      }
    }
    // Listen to the onPlayerCompletion event.
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlayingText = false;
      });
    });
  }

  Future<void> summarizeText({
    required SummarizerTextProvider summarizerTextProvider,
    required TextToAudioProvider textToAudioProvider,
    required SettingsProvider settingsProvider,
  }) async {
    summarizerTextProvider.clearError();
    try {
      textToAudioProvider.clearTextToVoiceModel();
      setState(() {
        _isLoading = true;
      });
      await summarizerTextProvider.summarizeTextProv(
        msg: _textController.text.trim(),
        summarySentenceCount: _summarySentenceCount,
        provider: settingsProvider.getTextSummarizerProvider,
        lang: settingsProvider.getLanguageModel.code,
      );
    } catch (error) {
      summarizerTextProvider.setError(
        error.toString(),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        if (outputText.currentContext != null) {
          Scrollable.ensureVisible(
            outputText.currentContext!,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  Future<void> copyFCT(summarizerTextProvider) async {
    await Clipboard.setData(
      ClipboardData(
        text: summarizerTextProvider.getSummarizerTextModel!.result,
      ),
    );
    const snackBar = SnackBar(
      content: Text('Copied to Clipboard!'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      _copySuccessful = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _copySuccessful = false;
      });
    });
  }
}
