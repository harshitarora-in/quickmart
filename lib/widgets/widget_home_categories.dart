import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quickmart/api_service.dart';
import 'package:quickmart/constants.dart';
import 'package:quickmart/models/category.dart' as categoryModel;
import 'package:quickmart/pages/product_page.dart';

class WidgetCategories extends StatefulWidget {
  WidgetCategories({Key? key}) : super(key: key);

  @override
  _WidgetCategoriesState createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  APIService? apiService;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14, 12, 14, 0),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 5),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0, top: 15.0, bottom: 5),
                child: Text(
                  "See all",
                  style: TextStyle(
                      color: kOrange,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 6),
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
          _categoriesList()
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
      future: apiService?.getCategories(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<categoryModel.Category>> model,
      ) {
        if (model.hasData) {
          return _buildCategoryList(model.data);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildCategoryList(List<categoryModel.Category>? categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
          height: 145,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: (categories!.length - 1),
            itemBuilder: (context, index) {
              var data = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                                categoryId: data.categoryId.toString(),
                              )));
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      width: 78,
                      height: 78,
                      alignment: Alignment.center,
                      child:
                          Image.network(data.image!.url.toString(), height: 80),
                      // decoration: BoxDecoration(boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black12,
                      //       offset: Offset(0, 5),
                      //       blurRadius: 15)
                      // ]),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 68,
                          child: Text(
                            data.categoryName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
