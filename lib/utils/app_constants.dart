//App Constants, instead of using their actual value we will use their constant names in the entire app.
class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  //Domain hosted server link: https://mvs.bslmeiyu.com/
  //Local hosted server at offie: 192.168.5.51:8083
  //Local hosted server at home: 192.168.1.95:8000
  static const String BASE_URL = "http://192.168.5.51:8083";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";
  // static const String DRINKS_URI = "/api/v1/products/drinks";

  //User and auth end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String USER_ADDRESS = "user_address";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "Cart-List";
  static const String CART_HISTORY_LIST = "Cart-History-List";

  //When you trying to host a local hosted server run this cmd when you run you server
  //php artisan serve --host='Here is your IP address' --port="Port"
}
