import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: false, // initial value
  key: "is_logged_in", // disk storage key for shared_preferences
);
final SharedValue<bool> is_admin = SharedValue(
  value: true, // initial value
  key: "is_admin", // disk storage key for shared_preferences
);

final SharedValue<String> access_token = SharedValue(
  value: "", // initial value
  key: "access_token", // disk storage key for shared_preferences
);

final SharedValue<String?> user_id = SharedValue(
  value: "", // initial value
  key: "user_id", // disk storage key for shared_preferences
);

final SharedValue<String> user_name = SharedValue(
  value: "", // initial value
  key: "user_name", // disk storage key for shared_preferences
);

final SharedValue<String?> user_email = SharedValue(
  value: "", // initial value
  key: "user_email", // disk storage key for shared_preferences
);

final SharedValue<String> user_phone = SharedValue(
  value: "", // initial value
  key: "user_phone", // disk storage key for shared_preferences
);