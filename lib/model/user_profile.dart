class UserProfile {
  final name;
  final email;
  final uid;
  final status;
  final isDriving;
  final image;
  final identity;
  final token;

  UserProfile(
      {this.uid,
      this.name,
      this.email,
      this.status,
      this.image,
      this.identity,
      this.isDriving,
      this.token});
}

class DriverProfile {

  final uid;
  final isDriving;
  final lastLogin;

  DriverProfile(
      {this.uid,
        this.lastLogin,
        this.isDriving});
}
