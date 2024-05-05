class EndPoints {
  static const String allCategories = '/api/v1/categories';
  static const String allBrands = '/api/v1/brands';
  static const String products = '/api/v1/products';

  static String getSubCategory(String categoryID) => '/api/v1/categories/$categoryID/subcategories';
  static const String signUp = '/api/v1/auth/signup';
  static const String signIn = '/api/v1/auth/signin';
  static const String updateData = '/api/v1/users/updateMe';
  static const String cart = '/api/v1/cart';

  static String updateCart(String productId) => '/api/v1/cart/$productId';

  static String deleteCart(String productId) => '/api/v1/cart/$productId';
}
