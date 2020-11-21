import 'package:flutter/material.dart';
import '../helpers/element.dart';
import '../models/element.dart';

class ElementProvider with ChangeNotifier {
  ElementServices _elementServices = ElementServices();
  List<ElementModel> elements = [];
  List<ElementModel> searchedElements = [];

  ElementModel element;
  //metodo
  ElementProvider.initialize() {
    _loadElements();
  }

  _loadElements() async {
    elements = await _elementServices.getElements();
    notifyListeners();
  }

  loadSingleElement({String elementId}) async {
    element = await _elementServices.getElementById(id: elementId);
    notifyListeners();
  }

  Future search({String name})async{
    searchedElements = await _elementServices.searchElement(elementName: name);
    print("productos encontrados: ${searchedElements.length}");
    notifyListeners();
  }
}
