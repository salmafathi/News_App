import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/components/components.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';

class NewsSienceScreen extends StatelessWidget {
  bool isError = false ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()..getScienceData(),
      child: BlocConsumer<NewsAppCubit,NewsAppStates>(
          builder: (context , state) {
            var scienceList = NewsAppCubit.get(context).scienceList ;
            return  scienceList.length > 0 ?
            RefreshIndicator(
              onRefresh: NewsAppCubit.get(context).getScienceData,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>articleItem(scienceList[index],context),
                  separatorBuilder: (context,index)=>separateItem(),
                  itemCount: 20),
            )
                : isError ? Center(child: Text('No Internet Connection'),) : Center(child: CircularProgressIndicator(),);
          },
          listener: (context , state) {
            if (state is NewsGetScienceErrorState)
              isError=true ;
          }
      ),
    );
  }
}
