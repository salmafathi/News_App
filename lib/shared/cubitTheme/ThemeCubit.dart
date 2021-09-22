import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/network/local/cache_helper.dart';

import 'ThemeStates.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(LightState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool currentMode = true;
  //if i call this fun with modefromShared so i am opening the app and read the value saved in shared
  void changeAppMode({ bool? modeFromShared}) {
    if(modeFromShared != null){
      currentMode = modeFromShared ;
      emit(DarkState());
    }
    else{
      currentMode = !currentMode;
      CachHelper.putDataInSharedPreference(mode: currentMode, key: 'mode')
          .then((value) => emit(DarkState()));
    }

  }
}
