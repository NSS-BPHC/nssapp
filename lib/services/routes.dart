const String BASE_URL = "https://nss-server.herokuapp.com";

const Map<String, List<String>> routes = {
  "get": [
    "/users/:userId",
    "/users/",
    "/users/reset-password/:id/:token",
    "/events/",
    "/register-event/:eventId",
    "/merch/",
    "/announcements/"
  ],
  "post": [
    "/users/",
    "/users/login",
    "/users/forgot-password",
    "/users/reset-password/:id/:token",
    "/events/",
    "/merch/",
    "/announcements/"
  ],
  "put": [],
  "patch": ["/users/:userId", "/score/:userId"],
  "delete": [
    "/users/:userId",
    "/register-event/:eventId",
    "/merch/",
    "/announcements/:announcementId"
  ]
};
