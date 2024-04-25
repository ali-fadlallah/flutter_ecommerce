class EndPoints {
  static const String allCategories = '/api/v1/categories';
  static const String allBrands = '/api/v1/brands';
  static const String products = '/api/v1/products';
  static String getSubCategory(String categoryID) => '/api/v1/categories/$categoryID/subcategories';
}