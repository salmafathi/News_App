import 'package:flutter/material.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';
import 'package:flutter_news_app/screens/newsbusiness/newsbusiness.dart';
import 'package:flutter_news_app/screens/newsseince/newsseince.dart';
import 'package:flutter_news_app/screens/newssport/newssport.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitialState());

  static NewsAppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0 ;
  List<BottomNavigationBarItem> bottomBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'الأعمال'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball),label: 'الرياضة'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'العلوم'),
  ];

  List<Widget> screens = [
    NewsBusinessScreen(),
    NewsSportScreen(),
    NewsSienceScreen(),
  ];

  List<String> titles = [
    'أخبار الأعمال',
    'أخبار الرياضة',
    'أخبار العلوم',
  ];
  void onTabButtomNavBar(int index){
    currentIndex = index ;
    emit(BottomNavState());
  }

  List<dynamic> businessList = [];
  Future<void> getBusinessData() async{
    emit(BusinessLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'4d2733feaa2a4040a4ecf479900b5689'
        }
    ).then((value) {
      businessList = value.data['articles'];
      print(businessList[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){

      print('${error.toString()} on Cubit get bussiness');
      emit(NewsGetBusinessErrorState());

    });
  }


  List<dynamic> scienceList = [];
  Future<void> getScienceData()async{
    emit(ScienceLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'4d2733feaa2a4040a4ecf479900b5689'
        }
    ).then((value) {
      scienceList = value.data['articles'];
      print(scienceList[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print('${error.toString()} on Cubit get science');
      emit(NewsGetScienceErrorState());
    });
  }

  List<dynamic> sportList = [];
  Future<void> getSportsData() async{
    emit(SportsLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'4d2733feaa2a4040a4ecf479900b5689'
        }
    ).then((value) {
      sportList = value.data['articles'];
      print(sportList[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print('${error.toString()} on Cubit get sports');
      emit(NewsGetSportsErrorState());
    });
  }


  List<dynamic> searchList = [];
  void getSearchData(String value){
    //searchList = [];
    emit(SearchLoadingState());
    DioHelper.getData(
        path: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'4d2733feaa2a4040a4ecf479900b5689'
        }
    ).then((value) {
      searchList = value.data['articles'];
      print(searchList[0]['title']);
      emit(NewsSearchSuccessState());
    }).catchError((error){
      print('${error.toString()} on Cubit get search');
      emit(NewsSearchErrorState());
    });
  }

}