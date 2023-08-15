import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPackagesHelper {
  AudioPackagesHelper._();

  static AudioProcessingState justAudioToServiceProcessingState(
    ProcessingState processingState,
  ) {
    return {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[processingState] ??
        AudioProcessingState.error;
  }

  static justAudioToServiceLoopMode(LoopMode loopMode) {
    return {
          LoopMode.all: AudioServiceRepeatMode.all,
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
        }[loopMode] ??
        AudioServiceRepeatMode.none;
  }

  static serviceToJustAudioLoopMode(AudioServiceRepeatMode repeatMode) {
    return {
      AudioServiceRepeatMode.all: LoopMode.all,
      AudioServiceRepeatMode.none: LoopMode.off,
      AudioServiceRepeatMode.one: LoopMode.one,
    }[repeatMode];
  }

  static AudioServiceRepeatMode getNextRepeatMode(
    AudioServiceRepeatMode currentMode,
  ) {
    if (currentMode == AudioServiceRepeatMode.none) {
      return AudioServiceRepeatMode.all;
    }
    if (currentMode == AudioServiceRepeatMode.all) {
      return AudioServiceRepeatMode.one;
    }

    return AudioServiceRepeatMode.none;
  }
}
