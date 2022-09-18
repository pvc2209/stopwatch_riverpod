import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/data.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default('') String id,
    @Default(false) bool loading,
    @Default(false) bool done,
    @Default(AsyncLoading()) AsyncValue<List<Data>> data,
    @Default(0) int selectedIndex,
    @Default(true) bool extended,
    @Default(8) int length,
    @Default('') String result,
    @Default(true) bool useNho,
    @Default(false) bool useTo,
    @Default(false) bool useNumber,
    @Default(false) bool useSymbol,
  }) = _HomeState;
}
