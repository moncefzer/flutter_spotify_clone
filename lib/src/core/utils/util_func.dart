Duration minDuration(Duration duration, Duration other) {
  if (duration.compareTo(other) < 0) {
    return duration;
  } else {
    return other;
  }
}
