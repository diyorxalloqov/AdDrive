class DriverProfile {
  // final ProfileDetails? profileDetails;
  // final VehicleDetails? vehicleDetails;
  // final DriverLicenses? driverLicenses;

  // DriverProfile({
  //   this.profileDetails,
  //   this.vehicleDetails,
  //   this.driverLicenses,
  // });
  //

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? zipCode;
  final String? carMake;
  final String? carModel;
  final String? carDetails;
  final String? carFrontImage;
  final String? carBackImage;
  final String? driverSideImage;
  final String? passengerSideImage;
  final String? licenseFrontSideImage;
  final String? licenseBackSideImage;

  DriverProfile({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.zipCode,
    this.carMake,
    this.carModel,
    this.carDetails,
    this.carFrontImage,
    this.carBackImage,
    this.driverSideImage,
    this.passengerSideImage,
    this.licenseFrontSideImage,
    this.licenseBackSideImage,
  });

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "zip_code": zipCode,
    "car_make": carMake,
    "car_model": carModel,
    "car_details": carDetails,
    "car_front_image": carFrontImage,
    "car_back_image": carBackImage,
    "driver_side_image": driverSideImage,
    "passenger_side_image": passengerSideImage,
    "license_front_side_image": licenseFrontSideImage,
    "license_back_side_image": licenseBackSideImage,
  };

}

// class ProfileDetails {
//   final String? firstName;
//   final String? lastName;
//   final String? phoneNumber;
//   final String? zipCode;
//
//   ProfileDetails({
//     this.firstName,
//     this.lastName,
//     this.phoneNumber,
//     this.zipCode,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "phone_number": phoneNumber,
//     "zip_code": zipCode,
//   };
// }
//
// class VehicleDetails {
//   final String? carMake;
//   final String? carModel;
//   final String? carDetails;
//   final String? carFrontImage;
//   final String? carBackImage;
//   final String? driverSideImage;
//   final String? passengerSideImage;
//
//   VehicleDetails({
//     this.carMake,
//     this.carModel,
//     this.carDetails,
//     this.carFrontImage,
//     this.carBackImage,
//     this.driverSideImage,
//     this.passengerSideImage,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "car_make": carMake,
//     "car_model": carModel,
//     "car_details": carDetails,
//     "car_front_image": carFrontImage,
//     "car_back_image": carBackImage,
//     "driver_side_image": driverSideImage,
//     "passenger_side_image": passengerSideImage,
//   };
// }
//
//
// class DriverLicenses {
//   final String? licenseFrontSideImage;
//   final String? licenseBackSideImage;
//
//   DriverLicenses({
//     this.licenseFrontSideImage,
//     this.licenseBackSideImage,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "license_front_side_image": licenseFrontSideImage,
//     "license_back_side_image": licenseBackSideImage,
//   };
// }