class Urls {
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static String sendEmailOtp(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryList = '$_baseUrl/CategoryList';
  static String popularProduct = '$_baseUrl/ListProductByRemark/Popular';
  static String specialProduct = '$_baseUrl/ListProductByRemark/Special';
  static String newProduct = '$_baseUrl/ListProductByRemark/New';
  static String productByCategory(int categoryId) =>
      '$_baseUrl/ListProductByBrand/$categoryId';

  static String productDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static String createCart = '$_baseUrl/CreateCartList';
  static String cartList = '$_baseUrl/CartList';
  static String wishList = '$_baseUrl/ProductWishList';
  static String invoiceCreate = '$_baseUrl/InvoiceCreate';
  static String reviewList(int id) => '$_baseUrl/ListReviewByProduct/$id';
  static String addWish(int id) => '$_baseUrl/CreateWishList/$id';
  static String removeWish(int id) => '$_baseUrl/RemoveWishList/$id';
}
