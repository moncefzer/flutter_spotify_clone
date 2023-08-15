import 'package:audio_service/audio_service.dart';

extension Audio on AudioServiceRepeatMode? {
  get ifNullNoneMode => this ?? AudioServiceRepeatMode.none;
}
