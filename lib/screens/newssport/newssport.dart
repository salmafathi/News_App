import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/components/components.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';

class NewsSportScreen extends StatelessWidget {
  bool isError = false ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()..getSportsData(),
      child: BlocConsumer<NewsAppCubit,NewsAppStates>(
          builder: (context , state) {
            var sportList = NewsAppCubit.get(context).sportList ;
            return  sportList.length > 0  ?
            RefreshIndicator(
              onRefresh: NewsAppCubit.get(context).getSportsData,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>articleItem(sportList[index],context),
                  separatorBuilder: (context,index)=>separateItem(),
                  itemCount: 20),
            )
                : isError ? Center(child: Text('No Internet Connection'),) : Center(child: CircularProgressIndicator(),);
          },
          listener: (context , state) {
            if (state is NewsGetSportsErrorState)
              isError=true ;
          }
      ),
    );
  }
}
