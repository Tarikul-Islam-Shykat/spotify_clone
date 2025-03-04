import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone/core/provider/current_user_notifier.dart';
import 'package:spotify_clone/core/theme/theme.dart';
import 'package:spotify_clone/features/auth/view/signIn_page.dart';
import 'package:spotify_clone/features/auth/viewModel/auth_viewmodel.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';
import 'package:spotify_clone/features/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();

  if (!Hive.isBoxOpen("localSongBox")) {
    await Hive.openBox('localSongBox');
  }

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPref();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Application',
      theme: AppTheme.darktheme,
      home: currentUser == null ? const SignInPage() : const HomeScreen(),
      // home: const UploadSongPage()
    );
  }
}
