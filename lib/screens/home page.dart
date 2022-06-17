import 'package:flutter/material.dart';
import 'package:flutter_17_api/bloc/product%20cubit.dart';
import 'package:flutter_17_api/bloc/productStates.dart';
import 'package:flutter_17_api/post.dart';
import 'package:flutter_17_api/screens/product%20details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
Map<String,String> categories = {
  "All":"all",
  "Electronics":"electronics",
  "Jewelery":"jewelery",
  "Men's clothing":"men's clothing",
  "Women's clothing":"women's clothing"

};
List<String> userCategories = categories.keys.toList();
class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        cubit.getProductsByCategory(categories[userCategories[index]]!);
                      }, child: Text("${userCategories[index]}")),
                ),
              ),
            ),
            BlocConsumer<ProductCubit, ProductStates>(
              listener: (context, state) {},
              builder: (context, state) => SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: ListView.builder(
                    itemCount: cubit.products.length,
                    itemBuilder: (context, index) {
                      //TextEditingController textC = TextEditingController();
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                        product: cubit.products[index]),
                                  ));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                        "${cubit.products[index].image}"),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 300,
                                          child: Text(
                                            "${cubit.products[index].title}",
                                            maxLines: 1,
                                            //overflow: TextOverflow.ellipsis,
                                          )),
                                      RatingBar.builder(
                                        initialRating: cubit
                                            .products[index].rate as double,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 12,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye,
                                            size: 15,
                                          ),
                                          Text("${cubit.products[index].count}")
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          //Post(textEditingController: textC)
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.getAllProducts();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
