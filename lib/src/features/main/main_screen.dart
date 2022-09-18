import 'package:andesgroup_common/common.dart';
import 'package:anim_clock/src/features/main/components/animated_stop_watch.dart';
import 'package:anim_clock/src/features/main/components/edit_dialog.dart';
import 'package:anim_clock/src/features/main/components/lap_card.dart';
import 'package:anim_clock/src/features/main/components/reset_button.dart';
import 'package:anim_clock/src/features/main/components/save_button.dart';
import 'package:anim_clock/src/features/main/components/start_stop_button.dart';
import 'package:anim_clock/src/features/main/providers/main_provider.dart';
import 'package:anim_clock/src/model/lap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iap_interface/iap_interface.dart';
import 'package:icons_plus/icons_plus.dart';
import '../home/home_providers.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MainState();
}

class _MainState extends ConsumerState<MainScreen> {
  final TextEditingController _textController =
      TextEditingController(text: 'Lap');

  final stopwatchKey = GlobalKey<AnimatedStopwatchState>();

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ref.read(mainProvider.notifier).reset();
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void _toggleRunning() {
    ref.read(mainProvider.notifier).toggleRunning();
    stopwatchKey.currentState?.toggleRunning(ref.read(mainProvider).isRunning);
  }

  void _reset() {
    ref.read(mainProvider.notifier).reset();
    stopwatchKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final mainState = ref.watch(mainProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Column(
          children: [
            const Gap(30.0),
            AnimatedStopwatch(
              key: stopwatchKey,
            ),
            const Gap(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 160.0,
                      height: 48.0,
                      child: StartStopButton(
                        isRunning: mainState.isRunning,
                        onPressed: _toggleRunning,
                      ),
                    ),
                    const Gap(20.0),
                    SizedBox(
                      width: 160.0,
                      height: 48.0,
                      child: ResetButton(
                        onPressed: _reset,
                      ),
                    ),
                  ],
                ),
                SaveButton(
                  isRunning: mainState.isRunning,
                  onPressed: () async {
                    final purchase =
                        await ref.read(homeProvider.notifier).checkPurchase();

                    if (!purchase) {
                      showAlertDialog(context,
                          title: 'Out of diamonds',
                          content:
                              'Please buy more diamonds or upgrade to continue using.',
                          titleOk: 'Upgrade & buy', onOk: () {
                        push(context,
                            ref.read(iapProvider.notifier).buyScreen());
                      });
                      return;
                    }

                    ref.read(iapProvider.notifier).useDiamonds();
                    ref.read(mainProvider.notifier).addLap(
                          _textController.text,
                          stopwatchKey.currentState?.elapsed ?? Duration.zero,
                        );
                  },
                  size: 120.0,
                ),
              ],
            ),
            const Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Bootstrap.box),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Lap name',
                ),
              ),
            ),
            const Gap(10.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: mainState.laps.length,
                itemBuilder: ((context, index) {
                  final lap = mainState.laps[index];

                  return LapCard(
                    lap: lap,
                    onTap: (lapName) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return editDialog(
                            context,
                            lapName,
                            onEdit: (value) {
                              final newLap = lap.copyWith(
                                name: value,
                              );

                              ref.read(mainProvider.notifier).editLap(newLap);
                            },
                          );
                        },
                      );
                    },
                    onDelete: () {
                      ref.read(mainProvider.notifier).removeLap(index);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
