// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_vierwmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllSongHash() => r'cb820f7b33f87a3cc34465a83566a8c47f0adf2e';

/// See also [getAllSong].
@ProviderFor(getAllSong)
final getAllSongProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllSong,
  name: r'getAllSongProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllSongHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllSongRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'c6ee9c6fc198fe24642096419f8b6612134e0f4e';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
