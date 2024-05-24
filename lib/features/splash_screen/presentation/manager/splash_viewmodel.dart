class SplashScreenViewModel {
  final int splashDuration = 1000; // in milliseconds

  Future<void> delay() async {
    return await Future.delayed(Duration(milliseconds: splashDuration));
  }
}
