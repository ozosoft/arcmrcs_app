import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/helper/shared_preference_helper.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/auth/login/login_response_model.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/repo/auth/login_repo.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/country_model/country_model.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser.obs; // Observe the user
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String? email;
  String? password;

  List<String> errors = [];
  bool remember = false;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = firebaseAuth.currentUser;
    firebaseAuth.authStateChanges().listen((user) {
      firebaseUser.value = user;
    });
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgetpasswordScreen);
  }

  void checkAndGotoNextStep(LoginResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;

    if (remember) {
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');

    // Get.toNamed(RouteHelper.bottomNavBarScreen);

    await loginRepo.sendUserToken();

    bool isProfileCompleteEnable = responseModel.data?.user?.regStep == '0' ? true : false;

    if (needSmsVerification == false && needEmailVerification == false) {
      if (isProfileCompleteEnable) {
        Get.offAndToNamed(RouteHelper.profileCompleteScreen);
      } else {
        Get.offAndToNamed(RouteHelper.bottomNavBarScreen);
      }
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true, isProfileCompleteEnable]);
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true, isProfileCompleteEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false, isProfileCompleteEnable]);
    }

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel model = await loginRepo.loginUser(emailController.text.toString(), passwordController.text.toString());

    if (model.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        checkAndGotoNextStep(loginModel);
      } else {
        CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';

    if (remember) {
      remember = false;
    }
    update();
  }





  //MOBILE AUTH START HERE

  initMobileAuthData() async {
    resetOtpPageData();
    await getCountryData();
  }

  RxString verificationId = ''.obs;
  bool sendOtpButtonLoading = false;
  bool isInOTPpage = false;
  bool isResendingOTP = false;
  int resendDelayInSeconds = 60; // Set the delay to 60 seconds
  Timer? _resendTimer;
  //to manage the search input.
  final TextEditingController searchController = TextEditingController();
  final TextEditingController otpFiledController = TextEditingController();
  //mian Counntry list
  List<Countries> countryList = [];
  //to hold the countries matching the search.
  List<Countries> filteredCountries = [];

  Countries selectedCountryData = Countries(country: "Bangladesh", countryCode: "BD", dialCode: "880");

  bool countryLoading = true;
  bool phoneNumberValidate = true;

// GET Country Data first
  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await loginRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      countryList.clear();
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
    }

    countryLoading = false;
    update();
  }

  selectCountryData(Countries value) {
    selectedCountryData = value;
    update();
  }

  validatePhoneNumber(bool value) {
    phoneNumberValidate = value;
    update();
  }

  changeOtpSendButtonLoading(bool value) {
    sendOtpButtonLoading = value;
    update();
  }

  changeOtpPageStatus(bool value) {
    isInOTPpage = value;
    update();
  }

  resetOtpPageData() {
    phoneNumberValidate = true;
    isInOTPpage = false;
    sendOtpButtonLoading = false;
    update();
  }

  Future<void> verifyPhoneNumber() async {
    try {
      changeOtpSendButtonLoading(true);
      String phoneNumber = "${MyStrings.plusText.tr}${selectedCountryData.dialCode}${mobileNumberController.text}";
      print(phoneNumber);
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user if verification is complete
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          changeOtpSendButtonLoading(false);
          Get.snackbar('Error', e.message!);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          // Get.toNamed('/otp'); // Navigate to the OTP screen
          print("Go To OTP PAGE");
          changeOtpPageStatus(true);
          changeOtpSendButtonLoading(false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          changeOtpSendButtonLoading(false);
        },
      );
    } catch (e) {
      changeOtpSendButtonLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signInWithOTP(String otp) async {
    try {
      changeOtpSendButtonLoading(true);
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await firebaseAuth.signInWithCredential(credential);

      print(firebaseUser.value!.uid);
      print(firebaseUser.value!.displayName);
      print(firebaseUser.value!.email);
      print(firebaseUser.value!.phoneNumber);
      print(firebaseUser.value!.photoURL);
      changeOtpSendButtonLoading(false);
    } catch (e) {
      changeOtpSendButtonLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> resendOTP(String phoneNumber) async {
    try {
      if (!isResendingOTP) {
        isResendingOTP = true;
        await verifyPhoneNumber();
        _startResendTimer();
      } else {
        Get.snackbar('Error', 'Resend is in progress');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isResendingOTP = false;
    }
  }

  void _startResendTimer() {
    _resendTimer = Timer(Duration(seconds: resendDelayInSeconds), () {
      isResendingOTP = false;
      _resendTimer?.cancel();
    });
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> signOutGoogleAuth() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In canceled by user');
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);

      print(firebaseUser.value!.uid);
      print(firebaseUser.value!.displayName);
      print(firebaseUser.value!.email);
      print(firebaseUser.value!.phoneNumber);
      print(firebaseUser.value!.photoURL);
    } catch (e) {
      print( e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  //Firebase Login part
}
