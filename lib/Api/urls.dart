class Urls {
  //static const String _baseUrl = "http://16.16.177.66:5000/api/v1";
  static const String _baseUrl = "http://43.205.54.218:5000/api/v1";
  static const String loginUrl = "$_baseUrl/users/login";
  static const String forgetPassword = "$_baseUrl/users/forgot-password";
  static const String verifyOtp = "$_baseUrl/users/verify-forgot-password-otp";
  static const String resetPassword = "$_baseUrl/users/reset-password";
  static const String getAllTicket = "$_baseUrl/tickets/view-all-my-tickets";
  static const String getUserDetails = "$_baseUrl/users/get-user";
  static const String editProfile = "$_baseUrl/users/edit-account";
  static const String returnTicket = "$_baseUrl/orders/return-tickets";
  static const String markAsSold = "$_baseUrl/orders/mark-sold";
  static const String soldTicketList = "$_baseUrl/orders/get-my-sales";
  static const String purchaseHistory = "$_baseUrl/orders/get-my-purchases";
}
