import 'package:eufloria/scr/helpers/screen_navigation.dart';
import 'package:eufloria/scr/helpers/style.dart';
import 'package:eufloria/scr/providers/app.dart';
import 'package:eufloria/scr/providers/element.dart';
import 'package:eufloria/scr/providers/product.dart';
import 'package:eufloria/scr/screens/element.dart';
import 'package:eufloria/scr/widgets/custom_text.dart';
import 'package:eufloria/scr/widgets/element.dart';
import 'package:eufloria/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElementsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final elementProvider = Provider.of<ElementProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Productos",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : elementProvider.searchedElements.length < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "No se encontraron productos",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 22,
                        ),
                      ],
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: elementProvider.searchedElements.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          await productProvider.loadProductsByElement(
                              elementId: elementProvider
                                  .searchedElements[index].id);
                          app.changeLoading();

                          changeScreen(
                              context,
                              ElementScreen(
                                elementModel: elementProvider
                                    .searchedElements[index],
                              ));
                        },
                        child: ElementWidget(
                            element:
                                elementProvider.searchedElements[index]));
                  }),
    );
  }
}