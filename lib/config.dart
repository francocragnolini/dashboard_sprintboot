// Production and Development url

String get apiHost {
  bool isProd = const bool.fromEnvironment('dart.vm.product');
  if (isProd) {
    // production api endpoint
    return 'https://admin-dashboard-fhjm.onrender.com/api';
    // replace with your production API endpoint
  }
  //development API endpoint
  return "http://localhost:8080/api";
}
