import 'package:andesgroup_common/common.dart';
import 'package:anim_clock/src/features/history/history_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iap_interface/iap_interface.dart';
import 'package:icons_plus/icons_plus.dart';

import '../main/main_screen.dart';
import 'home_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeScreen> {
  List<Widget> get pages => [
        const MainScreen(),
        const HistoryScreen(),
        ref.read(iapProvider.notifier).buyScreen(showAppbar: false),
      ];
  final pageCtl = PageController();
  final pageKey = GlobalKey();

  // TODO: update icon và label ở đây
  final iconButtons = [
    Bootstrap.clock,
    Bootstrap.save,
    Bootstrap.bag,
  ];
  final selectedIconButtons = [
    Bootstrap.clock_fill,
    Bootstrap.save_fill,
    Bootstrap.bag_fill,
  ];
  final labels = ['Stopwatch', 'History', 'Buy options'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(iapProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final diamonds = ref.watch(iapProvider.select((value) => value.diamonds));
    ref.listen<IapMessage?>(iapProvider.select((value) => value.message),
        (previous, next) {
      if (next != null && next.message?.isNotEmpty == true) {
        showSnackBar(context, next.message ?? '',
            backgroundColor: next.success ? Colors.green : null);
      }
    });
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Anim Clock'),
            leading: isLandscape
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      ref.read(homeProvider.notifier).toggleExtended();
                    },
                  )
                : null,
            actions: [
              Row(
                children: [
                  Icon(
                    Bootstrap.gem,
                  ),
                  const Gap(4),
                  Text(
                    diamonds.toString(),
                    style: TextStyles.t14SB,
                  ),
                  Gap(16),
                ],
              ),
            ],
          ),
          body: isLandscape
              ? Row(
                  children: <Widget>[
                    NavigationRail(
                      extended: ref.watch(
                          homeProvider.select((value) => value.extended)),
                      selectedIndex: ref.watch(
                          homeProvider.select((value) => value.selectedIndex)),
                      onDestinationSelected: (int index) {
                        ref
                            .read(homeProvider.notifier)
                            .selectedIndexChanged(index);
                        pageCtl.jumpToPage(index);
                      },
                      labelType: NavigationRailLabelType.none,
                      destinations: labels.mapIndexed((i, e) {
                        return NavigationRailDestination(
                          icon: Icon(iconButtons[i]),
                          selectedIcon: Icon(selectedIconButtons[i]),
                          label: Text(e),
                        );
                      }).toList(),
                    ),
                    // This is the main content.
                    Expanded(
                      child: PageView.builder(
                        key: pageKey,
                        controller: pageCtl,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return pages[index];
                        },
                      ),
                    ),
                  ],
                )
              : PageView.builder(
                  key: pageKey,
                  controller: pageCtl,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
          bottomNavigationBar: isLandscape
              ? null
              : NavigationBar(
                  onDestinationSelected: (int index) {
                    ref.read(homeProvider.notifier).selectedIndexChanged(index);
                    pageCtl.jumpToPage(index);
                  },
                  selectedIndex: ref.watch(
                      homeProvider.select((value) => value.selectedIndex)),
                  destinations: labels.mapIndexed((i, e) {
                    return NavigationDestination(
                      icon: Icon(iconButtons[i]),
                      selectedIcon: Icon(selectedIconButtons[i]),
                      label: e,
                    );
                  }).toList(),
                ),
        );
      },
    );
  }
}
