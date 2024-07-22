class ApiUrl {
  static String baseUrl = 'https://forthprodigital.in/demo/caringapp/Api/';
  static String loginUrl = '${baseUrl}user/login';
  static String signUpUrl = '${baseUrl}user/signup';
  static String forgotPasswordUrl = '${baseUrl}user/forgotpassword';
  static String forgotVerificationUrl = '${baseUrl}user/forget-verification';
  static String setNewPasswordUrl = '${baseUrl}user/set-new-password';
  static String signupVerifiactionUrl = '${baseUrl}user/signup-verification';
  static String homeUrl = '${baseUrl}home';
  static String profileDetailsUrl = '${baseUrl}profile/details';
  static String profileUpdateUrl = '${baseUrl}profile/update-profile';
  static String profilePhotoUrl = '${baseUrl}profile/update-photo';
  static String deleteAccountUrl = '${baseUrl}profile/delete-account';
  static String homeBookingListUrl = '${baseUrl}Mylisting/booking-list';
  static String bookingDetails = '${baseUrl}Mylisting/booking-detail';
  static String acceptBookingUrl = '${baseUrl}Mylisting/request-accept';
  static String sendMessageUrl = '${baseUrl}Mylisting/send-message-booking';
  static String bookingListUrl = '${baseUrl}Mylisting/booking-list-accepted';
  static String rejectBookingUrl = '${baseUrl}Mylisting/request-reject';
  static String bookingCompleteUrl = '${baseUrl}Mylisting/booking-complete';
  static String completedBookingListUrl =
      '${baseUrl}Mylisting/booking-list-completed-nurse';
  static String ratingUrl = '${baseUrl}rating/received';
  static String notificationurl = '${baseUrl}notification';
  static String readNotificationurl =
      '${baseUrl}Notification/read-notification';
  static String unreadNotificationCountUrl =
      '${baseUrl}notification/notification-unread-count';
}
