import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/search/search.dart';
import 'package:flutter_news_app/shared/components/components.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/cubitTheme/ThemeCubit.dart';
import 'package:flutter_news_app/shared/network/remote/dio_helper.dart';

class NewsAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(onPressed: (){
                navigateTo(context, Search());
            }, icon: Icon(Icons.search)),
            IconButton(
              icon: Icon(Icons.brightness_4_outlined),
              onPressed: () {
                ThemeCubit.get(context).changeAppMode();
              },),
          ],),
          body: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: cubit.screens[cubit.currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomBarItems,
            onTap: (index)=>cubit.onTabButtomNavBar(index),
          ),
        );
      },
    );
  }
}
