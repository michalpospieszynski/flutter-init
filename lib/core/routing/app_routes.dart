/// Route paths used by the router and by navigation helpers.
abstract final class AppRoutes {
  static const landing = '/';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const legalPrefix = '/legal';
  static const privacy = '$legalPrefix/privacy';
  static const terms = '$legalPrefix/terms';
}
