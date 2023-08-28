import 'package:flutter_prime/view/screens/authentication/forget_password/resetPassword/reset_Password_Screen.dart';
import 'package:flutter_prime/view/screens/authentication/forget_password/verification/verification_screen.dart';
import 'package:flutter_prime/view/screens/authentication/login/login_screen.dart';
import 'package:flutter_prime/view/screens/authentication/signUp/signUp_screen.dart';
import 'package:flutter_prime/view/screens/badges/badges_screen.dart';
import 'package:flutter_prime/view/screens/bookmark/bookmark_screen.dart';
import 'package:flutter_prime/view/screens/coin_history/coin_history_screen.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/catagori/gess_word_catagori_screen.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/gess_the_word_screen.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/result/gess_word_resultScreen.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/result/review/review_screen.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/subCatagori/gess_word_subcatagori_screen.dart';
import 'package:flutter_prime/view/screens/notification/notification_screen.dart';
import 'package:flutter_prime/view/screens/profile/profile-edit/Profile_edit_screen.dart';
import 'package:flutter_prime/view/screens/profile/profile_screen.dart';
import 'package:flutter_prime/view/screens/quiz-questions/quiz_question_screen.dart';
import 'package:flutter_prime/view/screens/splash/splash_screen.dart';
import 'package:flutter_prime/view/screens/wallet/wallet_screen.dart';
import 'package:flutter_prime/view/screens/coin_store/coin_store_screen.dart';

import 'package:get/get.dart';

import '../../view/screens/1vs1/find-opponents-screen/find_opponent_screen.dart';
import '../../view/screens/1vs1/one_vs_one_battle_screen.dart';
import '../../view/screens/1vs1/play-with-friends-bottom-sheet/rooms/create-room/create_room_screen.dart';
import '../../view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/join_room_screen.dart';
import '../../view/screens/all-categories/all_categories_screen.dart';
import '../../view/screens/authentication/forget_password/forgetpassword/forget_password_screen.dart';
import '../../view/screens/bottom_nav_bar/bottom_navigation_bar_screen.dart';
import '../../view/screens/exam_zone/exam_zone_screen.dart';
import '../../view/screens/homepage/homepage-widgets/home-body-sections/exam_zone/exam_zone_category_screen.dart';
import '../../view/screens/homepage/homepage-widgets/home-body-sections/sub-categories/sub_categories_card_screen.dart';
import '../../view/screens/intro_section/onboard_intro_screen.dart';
import '../../view/screens/leader_board/leader_board_screen.dart';
import '../../view/screens/quiz-result/quiz_result_screen.dart';
import '../../view/screens/review-answer/review_answer-screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = '/onboard_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signUp_screen';
  static const String forgetpasswordScreen = '/forget_password_screen';
  static const String verificationScreen = '/verification_screen';
  static const String resetPassword = '/reset_password_screen';
  static const String bottomNavBarScreen = '/bottom_navigation_screen';
  static const String allCategories = '/all_categories_screen';
  static const String subCategories = '/top_categories_screen';
  static const String quizQuestionsScreen = '/quiz_questions_screen';
  static const String quizResultScreen = '/quiz_result_screen';
  static const String reviewAnswerScreen = '/review_answer_screen';
  static const String oneVSoneBattleScreen = '/battle_screen';
  static const String findOpponentScreen = '/find_opponent_screen';
  static const String createRoomScreen = '/create_room_screen';
  static const String joinRoomScreen = '/join_room_screen';
  static const String profileScreen = '/profile_screen';
  static const String profileEditScreen = '/profile__edit_screen';
  static const String coinStroeScreen = '/coin_store_screen';
  static const String badgesScreen = '/badges_screen';
  static const String coinHistoryScreen = '/coin_history_screen';
  static const String walletScreen = '/wallet_screen';
  static const String bookmarkScreen = '/bookmark_screen';
  static const String notificationScreen = '/notification_screen';
  static const String examZoneScreen = '/exam_zone_screen';
  static const String examZoneCategoryScreen = '/exam_zone_category_screen';
  static const String leaderBoardScreen = '/leader_board_screen';
  // guess the word
  static const String gessTheword = "/gess_the_word";
  static const String gessThewordCatagori = "/gess_the_word_catagori";
  static const String gessThewordsubCatagori = "/gess_the_word_subCatagroi";
  static const String gessThewordResult = "/gess_the_word_result";
  static const String gessThewordResultReview = "/gess_the_word_result_review";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardIntroScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen()),
    GetPage(name: forgetpasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verificationScreen, page: () => const VerificationScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: bottomNavBarScreen, page: () => const BottomNavigationBarScreen()),
    GetPage(
        name: subCategories,
        page: () => const SubCategoriesCardScreen(
              title: "",
            )),
    GetPage(name: allCategories, page: () => const AllCategoriesScreen()),
    GetPage(name: quizQuestionsScreen, page: () => const QuizQuestionsScreen()),
    GetPage(name: quizResultScreen, page: () => const QuizResultScreen()),
    GetPage(name: reviewAnswerScreen, page: () => const ReviewAnswerScreen()),
    GetPage(name: oneVSoneBattleScreen, page: () => const OneVSOneBattleScreen()),
    GetPage(name: findOpponentScreen, page: () => const FindOpponenetScreen()),
    GetPage(name: createRoomScreen, page: () => const CreateRoomScreen()),
    GetPage(name: joinRoomScreen, page: () => const JoinRoomScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: profileEditScreen, page: () => const ProfileEditScreen()),
    GetPage(name: coinStroeScreen, page: () => const CoinStoreScreen()),
    GetPage(name: badgesScreen, page: () => const BadgesScreen()),
    GetPage(name: coinHistoryScreen, page: () => const CoinHistoryScreen()),
    GetPage(name: walletScreen, page: () => const WalletScreen()),
    GetPage(name: bookmarkScreen, page: () => const BookmarkScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: examZoneScreen, page: () => const ExamZoneScreen()),
    GetPage(name: examZoneCategoryScreen, page: () => const ExamZoneCategoryScreen()),
    GetPage(name: leaderBoardScreen, page: () => const LeaderBoardScreen()),
    // guess the word
    GetPage(name: gessTheword, page: () => const GessThewordScreen()),
    GetPage(name: gessThewordCatagori, page: () => const GestheWordCatagoriScreen()),
    GetPage(name: gessThewordsubCatagori, page: () => const GessWordSubCatagoriScreen()),
    GetPage(name: gessThewordResult, page: () => const GessWordResultScreen()),
    GetPage(name: gessThewordResultReview, page: () => const GessWordReviewResult()),
  ];
}
