import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';

class FirebaseLocationService {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('adgari');

  Future addLocationData({required DriverLocationModel position, uid}) async {
    return await _collectionReference
        .doc('adgari_users')
        .collection('users')
        .doc(uid)
        .collection('location')
        .doc('data')
        .set(position.toJson());
  }

  DriverLocationModel? getDriverLocation(DocumentSnapshot? documentSnapshot) {
    return documentSnapshot?.data != null
        ? DriverLocationModel.fromJson(documentSnapshot?.data() as Map)
        : null;
  }

  Stream<DriverLocationModel?> getDriverData({did}) {
    return _collectionReference
        .doc('adgari_users')
        .collection('users')
        .doc(did)
        .collection('location')
        .doc('data')
        .snapshots()
        .map(getDriverLocation);
  }

  //create new user
  void createAndUpdateUserInfo({map, uid}) {
    _collectionReference
        .doc('tadgari_users')
        .collection('users')
        .doc(uid)
        .set(map);
  }

  void updateUserField({map, uid}) {
    _collectionReference
        .doc('adgari_users')
        .collection('users')
        .doc(uid.toString())
        .set(map);
  }

  Stream<DriverProfile> getUserProfile(uid) {
    return _collectionReference
        .doc('adgari_users')
        .collection('users')
        .doc(uid.toString())
        .snapshots()
        .map(getProfileDataFromSnapshot);
  }

  DriverProfile getProfileDataFromSnapshot(DocumentSnapshot doc) {
    return DriverProfile(
        uid: doc['uid'] ?? '',
        isDriving: doc['is_driving'] ?? '0',
        lastLogin: doc['last_login'] ?? '');
  }

  // //return stream type search list of users
  // Stream<List<UserProfile>> searchUserByIdentity(String code) {
  //   return _collectionReference
  //       .doc('taxi_tracker_users')
  //       .collection('users')
  //       .where('identity', isEqualTo: code)
  //       .snapshots()
  //       .map(getChatFriendFromFireStore);
  // }

  //return friend object from query
  // List<UserProfile> getChatFriendFromFireStore(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return UserProfile(
  //         uid: doc['uid'] ?? '',
  //         name: doc['name'] ?? '',
  //         email: doc['email'] ?? '',
  //         status: doc['status'] ?? '1',
  //         image: doc['image'] ?? '',
  //         identity: doc['identity'] ?? '');
  //   }).toList();
  // }

  ///addDriverToTheList
  // Future<void> addAsDriver({UserProfile profile, uid}) async {
  //   Map<String, dynamic> map = {
  //     'timestamp': '${Timestamp.now().seconds}',
  //     'name': '${profile.name}',
  //     'uid': '${profile.uid}',
  //     'image': '${profile.image}',
  //     'email': '${profile.email}',
  //     'identity': '${profile.identity}',
  //     'token': '${profile.token}',
  //     'status': '${profile.status}',
  //     'is_driving': '${profile.isDriving}',
  //   };
  //
  //   return _collectionReference
  //       .doc('taxi_tracker_users')
  //       .collection('users')
  //       .doc(uid)
  //       .collection('drivers')
  //       .doc(profile.uid)
  //       .set(map)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  ///get all driver from firebase
  Stream<List<DriverProfile>> getDrivers({uid}) {
    return _collectionReference
        .doc('adgari_users')
        .collection('users')
        .doc(uid)
        .collection('drivers')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(getAllDriver);
  }

  ///get list of driver from query
  List<DriverProfile> getAllDriver(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DriverProfile(
          uid: doc['uid'] ?? '',
          lastLogin: doc['last_login'] ?? '',
          isDriving: doc['is_driving'] ?? '');
    }).toList();
  }
}
