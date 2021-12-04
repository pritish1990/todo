// ignore: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/home.dart';

import 'box.dart';

class AuthController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var _authresult;
  Rx<UserModel?> userModel = UserModel().obs;

  Future<String?> signInwithGoogle() async {
    // await EasyLoading.show(status:"Loading..");
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      _authresult = await _auth.signInWithCredential(credential);
      if(_authresult.additionalUserInfo!.isNewUser){
       try{
         userModel.value= UserModel(
             uid: _auth.currentUser!.uid,
             imageUrl:_auth.currentUser!.photoURL,
           userEmail: _auth.currentUser!.email,
           username: _auth.currentUser!.displayName
        );
         await storeInSharedPreference();
         await storeInFirebase();
         Get.off(HomePage());
       } catch (e) {
         debugPrint('Error: ${e.toString()}');
       }
        // EasyLoading.dismiss();
      } else{
      await storeFromFirebase();
      await storeInSharedPreference();
      Get.off(HomePage());
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }

  }

  Future<void> storeInSharedPreference() async {
    await box.write('uid', userModel.value!.uid);
  }


  Future<void> storefromSharedPreference() async {

  }

  Future<void> storeInFirebase() async {
    await firebase
        .collection('user')
        .doc(_auth.currentUser!.uid)
        .set(userModel.toJson(),SetOptions(merge: true));
  }
  Future<UserModel?> storeFromFirebase() async {
    DocumentSnapshot<Map<String,dynamic>> data = await firebase.collection('user').doc(_auth.currentUser!.uid)
        .get();
    if(data.exists){
      return UserModel.fromJson(data.data()!);
    }else{
      return null;
    }

  }


  Future<void> signOut() async{
    await EasyLoading.show(status: 'loading..');
    try{
      await _auth.signOut();
    } catch(e){
      clear();
    }
  }

  void clear() {
    userModel.value = userModel();
  }
}

