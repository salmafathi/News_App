import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/newslayout.dart';
import 'package:flutter_news_app/shared/blocobserver.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';
import 'package:flutter_news_app/shared/cubitTheme/ThemeCubit.dart';
import 'package:flutter_news_app/shared/cubitTheme/ThemeStates.dart';
import 'package:flutter_news_app/shared/network/local/cache_helper.dart';
import 'package:flutter_news_app/shared/network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  //get theme info from shared preference
  await CachHelper.init() ;
  bool? mode = CachHelper.getDataFromSharedPreference(key: 'mode');

  //if it is the first time to open app so mode = null = light theme = true.
  if(mode == null )
    runApp(MyApp(true));
  else
  runApp(MyApp(mode));
}

class MyApp extends StatelessWidget {
  final bool appMode ;
  MyApp(this.appMode);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsAppCubit(),),
        BlocProvider(create: (BuildContext context) => ThemeCubit()..changeAppMode(modeFromShared: appMode) ,),
      ],
      child: BlocConsumer<ThemeCubit,ThemeStates>(
        builder: (context , states ) => MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
              backwardsCompatibility: false,
              backgroundColor: Colors.white,
              elevation: 1.0,
              iconTheme: IconThemeData(
                color: Colors.black54,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 10.0
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),

          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('333739'),
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: HexColor('333739'), statusBarIconBrightness: Brightness.light),
              backwardsCompatibility: false,
              backgroundColor: HexColor('333739'),
              elevation: 1.0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 10.0,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),


            ),


          ),

          themeMode: ThemeCubit.get(context).currentMode ? ThemeMode.light : ThemeMode.dark ,

          home:Directionality(textDirection: TextDirection.rtl,

          child: NewsAppLayout()),

        ),
        listener: (context , states){},
      ),
    );
  }
}


