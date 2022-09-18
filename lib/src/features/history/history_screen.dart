import 'package:anim_clock/src/features/history/providers/history_provider.dart';
import 'package:anim_clock/src/features/main/components/edit_dialog.dart';
import 'package:anim_clock/src/features/main/components/lap_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(historyProvider.notifier).loadLaps();
  }

  @override
  Widget build(BuildContext context) {
    final laps = ref.watch(historyProvider.select((value) => value.laps));

    return Center(
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: laps.length,
        itemBuilder: ((context, index) {
          final lap = laps[index];
          return LapCard(
            lap: lap,
            onDelete: () {
              ref.read(historyProvider.notifier).removeLap(laps[index]);
            },
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

                      ref.read(historyProvider.notifier).editLap(newLap);
                    },
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
