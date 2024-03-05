class Urls {
  // static const String _baseUrl =
  //     "http://13.127.33.196:4001/api/v1"; // test dev api without slot id
  // static const String _baseUrl =
  //     "https://api.singhamlottery.in/api/v1"; // production

  static const String _baseUrl =
      "https://devapi.singhamlottery.in/api/v1"; //dev api
  static const String encKey1 =
      "8bx4lQmIK1pDxxlXpDbMdrDxqA75EHtX4WyYOtI4zlWOFox1pRJ9LZCkQ2wSUDglPXH59saoUGA9Noi7mmRdtm8Iao64RscPH0mhSwEsVIwDtUzO1ZHvvGee4gvkvViW";
  static const String encKey2 =
      "WzxefYBrnfsQGDf6KsayoDRRo9dRE4yq9plUtZ0PJsIvYElHOHFArj2m0AAySf8SDjWE8Hr3L1FWsUqg5AgO224HLybYjZbRHI2JYq5MgYzqI2cbltzO9fEK9JlEXV0I";
  static const String loginUrl = "$_baseUrl/users/login";
  static const String forgetPassword = "$_baseUrl/users/forgot-password";
  static const String verifyOtp = "$_baseUrl/users/verify-forgot-password-otp";
  static const String resetPassword = "$_baseUrl/users/reset-password";
  static const String getAllTicket = "$_baseUrl/tickets/view-all-my-tickets";
  static const String getUserDetails = "$_baseUrl/users/get-user";
  static const String editProfile = "$_baseUrl/users/edit-account";
  static const String returnTicket = "$_baseUrl/orders/return-tickets";
  // static const String markAsSold = "$_baseUrl/orders/mark-sold";
  static const String markAsSold = "$_baseUrl/orders/retailer-create-sale";
  static const String soldTicketList = "$_baseUrl/orders/get-my-sales";
  static const String purchaseHistory = "$_baseUrl/orders/get-my-purchases";
  static const String verifyTickets = "$_baseUrl/verify-ticket";
  static const String verifyTicketById = "$_baseUrl/tickets/search-ticket";
  static const String contactUs = "$_baseUrl/users/contact-us";
  static const String getMyreturn = "$_baseUrl/orders/get-my-returns";
  static const String deleteMyReturn = "$_baseUrl/orders/delete-returns";
  static const String revertMySale = "$_baseUrl/orders/revert-sales";
  static const String getAllPurchaseDetails =
      "$_baseUrl/orders/get-order-tickets";
  static const String validateReturnTicket =
      "$_baseUrl/orders/check-return-series";

  /// validate sale ticket
  static const String validateSaleTicket =
      "$_baseUrl/orders/retailer-check-sale-list";
  // get dashboard details
  static const String getMyDashboard = "$_baseUrl/users/get-my-dashboard";
  static const String getPrize = "$_baseUrl/lottery/get-result";

  /// pwt
  static const String myPwtSoldUnsoldData =
      "$_baseUrl/lottery/my-pwt-sold-unsold-data";
  // get slot
  static const String getSlot = "$_baseUrl/lottery/get-draw-slots";
  static const String serverTime = "$_baseUrl/get-draw-time";
  static const String returnSeriesList = "$_baseUrl/orders/return-series-list";

  static const String getmycnf = "$_baseUrl/users/get-my-cnf";
  static const String scanPwt = "$_baseUrl/lottery/scan-pwt";
  static const String getMyclaims = "$_baseUrl/users/get-my-claims-date";
  static const String claimTicket =
      "$_baseUrl/lottery/claim-ticket-series-request-list";

  /// billing
  static const String myBills = "$_baseUrl/orders/view-user-bill/";

  /// set online off line
  static const String setInactiveState =
      "$_baseUrl/users/unmount-user-online-counts";
  static const String setActiveState = "$_baseUrl/users/set-active-status";
}
