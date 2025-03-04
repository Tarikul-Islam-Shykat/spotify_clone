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
String _$getAllFavSongHash() => r'36882503d5b7f838b5740091f5314de24d906234';

/// See also [getAllFavSong].
@ProviderFor(getAllFavSong)
final getAllFavSongProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllFavSong,
  name: r'getAllFavSongProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllFavSongHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllFavSongRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'283c054da9821be49d5530e915f3f07c88660f78';

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
