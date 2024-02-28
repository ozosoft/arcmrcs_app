import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyCoinsController extends GetxController {
  final InAppPurchase _iap = InAppPurchase.instance;

  List packData = [];
  String newCoin = "";
  int index = 0;
    final Set<String> _kIds = {'package1', 'package2', 'package3', 'package4'};
     int totalCoins = 0; 

  void changeIndex(int index) {
    this.index = index;
    newCoin = packData[index].description.replaceAll("Credits", "");
    update();
  }

  bool controllerLoading = false;

  Future<void> loadProducts() async {
    controllerLoading = true;
    update();
    final bool isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      print("In-app purchases not available.");
      controllerLoading = false;
      update();
      return;
    }
    
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      print("Products not found.");
      controllerLoading = false;
      update();
      return;
    }

    packData = response.productDetails;
    if (packData.isEmpty) {
      print('No products found with the specified IDs');
      controllerLoading = false;
      update();
      return;
    }

    newCoin = packData[index].description.replaceAll("Credits", "");
    print("Pack data loaded successfully.");
    controllerLoading = false;
    update();
  }

 Future<void> purchaseProduct(ProductDetails product) async {
  try {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    bool canMakePurchase = await _iap.isAvailable();

    if (!canMakePurchase) {
      print("In-app purchases not available.");
      return;
    }

    StreamSubscription<List<PurchaseDetails>>? subscription;
    subscription = _iap.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) async {
      for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          print("Purchase was successful");
          CustomSnackBar.success(successList: [MyStrings.packPurchasedSuccessfully]);

          // Retrieve and print the amount of coins or credits bought
          if (_kIds.contains(purchaseDetails.productID)) {
            final ProductDetails purchasedProduct = packData.firstWhere((product) => product.id == purchaseDetails.productID);
            final int amountBought = int.parse(purchasedProduct.description.replaceAll("Credits", ""));
            print('Amount bought: $amountBought');

            // Update totalCoins
            totalCoins += amountBought;
          }
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          print("Purchase failed with error: ${purchaseDetails.error}");
          CustomSnackBar.error(errorList: [MyStrings.failedToPurchasedPack]);
        } else if (purchaseDetails.status == PurchaseStatus.pending) {
          print("Purchase is pending");
          CustomSnackBar.success(successList: [MyStrings.purchaseIsPending]);
        } else {
          print("Purchase was canceled");
          CustomSnackBar.error(errorList: [MyStrings.purchaseWasCanceled]);
        }
      }

      // Cancel the subscription after processing purchase details
      subscription?.cancel();
    });

    // Initiate the purchase
    final bool purchaseResult = await _iap.buyNonConsumable(purchaseParam: purchaseParam);

    if (!purchaseResult) {
      print("Purchase was canceled or failed");
      // If purchaseResult is false, handle the cancellation or failure here
      subscription?.cancel();
    }
  } catch (error) {
    print('Error during purchase: $error');
  }
}
}

