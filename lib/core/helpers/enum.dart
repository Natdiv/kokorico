enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum AppMode {
  MODE_ADMIN,
  MODE_USER,
}

enum FisrtTime {
  FIRST_TIME,
}

// ModeAdmin of the app
enum ModeAdmin {
  MODE_ADMIN,
}

// States for order
enum OrderStatus {
  PENDING,
  PROCESSING,
  COMPLETED,
  CANCELLED,
}

enum PaymentMethod {
  CASH,
  MOBILE_MONEY,
}

enum PaymentStatus {
  PENDING,
  PAID,
}

enum DeliveryStatus {
  PENDING,
  DELIVERED,
}
