import 'package:flutter/material.dart';

enum SearchBy { PRODUCTS }

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}) {
    search = newSearchBy;
    notifyListeners();
  }

  addPrice({int newPrice}) {
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}) {
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice() {
    print("el total es: $priceSum");
    print("la cantidad total es: $quantitySum");
    print("el precio total es: $totalPrice");
    totalPrice = priceSum * quantitySum;
    notifyListeners();
  }
}
