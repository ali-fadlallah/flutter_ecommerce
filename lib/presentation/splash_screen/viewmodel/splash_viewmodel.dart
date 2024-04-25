class SplashScreenViewModel {
  final int splashDuration = 1000; // in milliseconds

  Future<void> delay() {
    return Future.delayed(Duration(milliseconds: splashDuration));
  }
}
