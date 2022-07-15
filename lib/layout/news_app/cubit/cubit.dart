import 'package:application1/layout/news_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    //BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting')
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingsScreen()
  ];
  void ChangeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'ae1a59e12c104b01997085796dab74bd'
    }).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'ae1a59e12c104b01997085796dab74bd'
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'ae1a59e12c104b01997085796dab74bd',
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: '/v2/everything', query: {
      'q': '$value',
      'apiKey': 'ae1a59e12c104b01997085796dab74bd',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
