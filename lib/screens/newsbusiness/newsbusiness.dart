import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/components/components.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';

class NewsBusinessScreen extends StatelessWidget {
  bool isError = false ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()..getBusinessData(),
      child: BlocConsumer<NewsAppCubit,NewsAppStates>(
          builder: (context , state) {
            var businessList = NewsAppCubit.get(context).businessList ;

          return  businessList.length >0 ?
          RefreshIndicator(
            onRefresh: NewsAppCubit.get(context).getBusinessData,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>articleItem(businessList[index],context),
                separatorBuilder: (context,index)=>separateItem(),
                itemCount: 20),
          )
            : isError ? Center(child: Text('No Internet Connection'),) : Center(child: CircularProgressIndicator(),);
          },
          listener: (context , state) {
            if (state is NewsGetBusinessErrorState)
              isError=true ;
          }
          ),
    );
  }
}
