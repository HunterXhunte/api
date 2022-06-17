import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_17_api/bloc/productStates.dart';
import 'package:flutter_17_api/models/product%20model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  Dio dio = Dio();
  ProductCubit() : super(InitialStete()){

      getAllProducts();

  }
  List<ProductModel> products = [];
  List<ProductModel> cart =[];
  static ProductCubit get(BuildContext context)=>BlocProvider.of(context);
  getAllProducts() async {
    products=[];
    if(products.isEmpty){
      var response = await dio.get("https://fakestoreapi.com/products");
      if(response.statusCode == 200){
        List<dynamic> data = response.data;
        data.forEach((element) {
          ProductModel pm = ProductModel.fromJson(element);
          products.add(pm);
        });
        emit(GetProducts());
        print(response.data.runtimeType);
        print(response.data);
      }
    }
  }
  getProductsByCategory(String category)async{
    //https://newsapi.org/v2/top-headlines?language=en&apiKey=e60394104032466cae812699f6e6826f
    //https://fakestoreapi.com/products/category/jewelery
    products = [];
    if(category == "all"){
      getAllProducts();
    }else{
      try{
        var response =await dio.get("https://fakestoreapi.com/products/category/$category");
        if(response.statusCode == 200){

          List<dynamic> data = response.data;
          data.forEach((element) {
            ProductModel pm = ProductModel.fromJson(element);
            products.add(pm);
          });
          emit(GetProducts());
          print(response.data.runtimeType);
          print(response.data);
        }
      } on DioError catch(q){
        print(q);
        //return q.toString();
      }
    }
  }
}
