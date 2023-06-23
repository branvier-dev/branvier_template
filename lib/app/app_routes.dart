// ignore_for_file: prefer_function_declarations_over_variables


/// App [Routes].
mixin Routes {
  // * User Module
  static const home = '/home/';
  static const books = '/home/books';
  static final book = (id) => '/home/books/$id/';

  // * Auth Module
  static const login = '/auth/login/';
  static const register = '/auth/register/';
}
