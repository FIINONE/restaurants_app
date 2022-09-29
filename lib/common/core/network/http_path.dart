abstract class AppHttpPath {
  static const shema = 'http://';
  static const host = '188.225.83.80:6719';

  //авторизация
  static const getProfile = '/api/v1/auth/login/profile';
  static const login = '/api/v1/auth/login';
  static const registration = '/api/v1/auth/registration/customer/new';
  static const refreshToken = '/api/v1/auth/login/refresh';

  //рестораны
  static const restaurantsAll = '/api/v1/restaurants/all';
  static const restaurantSpecific = '/api/v1/restaurants/details/';
  static const restaurantNew = '/api/v1/restaurants/restaurants/new';

  // избранное
  static const favorite = '/api/v1/likes/all';
  static const favoriteAdd = '/api/v1/likes/new';
  static const favoriteDelete = '/api/v1/likes/';
}
