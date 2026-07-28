import 'dart:async';
import 'dart:developer' as developer;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';
import 'package:pinball/app/app.dart';
import 'package:pinball/bootstrap.dart';
import 'package:pinball/firebase_options.dart';
import 'package:pinball_audio/pinball_audio.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:share_repository/share_repository.dart';

Future<App> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final leaderboardRepository =
      LeaderboardRepository(FirebaseFirestore.instance);
  const shareRepository =
      ShareRepository(appUrl: ShareRepository.pinballGameUrl);
  final authenticationRepository =
      AuthenticationRepository(FirebaseAuth.instance);
  final pinballAudioPlayer = PinballAudioPlayer();
  final platformHelper = PlatformHelper();

  try {
    await authenticationRepository.authenticateAnonymously();
  } on AuthenticationException catch (error, stackTrace) {
    // Play as a guest rather than leaving the app stuck on a blank screen:
    // sign-in only fails when Firebase isn't configured for this environment
    // (e.g. no valid API key), and nothing in the core gameplay actually
    // requires a signed-in user - only score submission does.
    developer.log(
      'Anonymous sign-in failed, continuing as guest.',
      name: 'bootstrap',
      error: error,
      stackTrace: stackTrace,
    );
  }

  return App(
    authenticationRepository: authenticationRepository,
    leaderboardRepository: leaderboardRepository,
    shareRepository: shareRepository,
    pinballAudioPlayer: pinballAudioPlayer,
    platformHelper: platformHelper,
  );
}

void main() async {
  Bloc.observer = AppBlocObserver();
  runApp(await bootstrap());
}
