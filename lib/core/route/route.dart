import 'package:flutter_prime/view/screens/authentication/forget_password/resetPassword/reset_Password_Screen.dart';
import 'package:flutter_prime/view/screens/authentication/forget_password/verification/verification_screen.dart';
import 'package:flutter_prime/view/screens/authentication/login/login_screen.dart';
import 'package:flutter_prime/view/screens/authentication/signUp/signUp_screen.dart';
import 'package:flutter_prime/view/screens/badges/badges_screen.dart';
import 'package:flutter_prime/view/screens/battle-quiz-section/quiz_question_screen.dart';
import 'package:flutter_prime/view/screens/bookmark/bookmark_screen.dart';
import 'package:flutter_prime/view/screens/coin_history/coin_history_screen.dart';
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
import '../../view/screens/homepage/homepage-widgets/home-body-sections/top-categories/top_categories_card_screen.dart';
import '../../view/screens/intro_section/onboard_intro_screen.dart';
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
  static const String topCategories = '/top_categories_screen';
  static const String quizQuestionsScreen = '/quiz_questions_screen';
  static const String battleQuizQuestionsScreen =
      '/battleq_uiz_questions_screen';
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

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardIntroScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen()),
    GetPage(
        name: forgetpasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verificationScreen, page: () => const VerificationScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: bottomNavBarScreen,
        page: () => const BottomNavigationBarScreen()),
    GetPage(
        name: topCategories,
        page: () => const TopCategoriesCardScreen(
              title: "",
            )),
    GetPage(name: allCategories, page: () => const AllCategoriesScreen()),
    GetPage(name: quizQuestionsScreen, page: () => const QuizQuestionsScreen()),
    GetPage(
        name: battleQuizQuestionsScreen,
        page: () => const BattleQuizQuestionsScreen()),
    GetPage(name: quizResultScreen, page: () => const QuizResultScreen()),
    GetPage(name: reviewAnswerScreen, page: () => const ReviewAnswerScreen()),
    GetPage(
        name: oneVSoneBattleScreen, page: () => const OneVSOneBattleScreen()),
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
  ];
}
