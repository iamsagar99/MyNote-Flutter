import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String email;
  String fullName;

  OurUser({
    required this.uid,
    required this.email,
    required this.fullName,

  });
}