

var year = DateTime.now().year.toString();

class AppConfig {
  static String app_name = "CarRentalApp";
  static String collection_name = "PhotoApp-2023";
  static String folder_name = "files/";
  //Http config
  static const bool HTTPS = true;

  //Domain Config
  static const DOMAIN_PATH = "";

  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}";


}
