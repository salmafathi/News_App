import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/shared/components/components.dart';
import 'package:flutter_news_app/shared/cubit/cubit.dart';
import 'package:flutter_news_app/shared/cubit/states.dart';

class Search extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener: (context,state){
      },
      builder: (context,state) {
        var searchList = NewsAppCubit.get(context).searchList ;
        return Scaffold(
          appBar: AppBar(elevation: 0.0,),
          body: Column(
            children: [
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child : defaultTextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'search mist not be empty' ;
                    }
                    return null ;
                  },
                onChange: (value){
                    NewsAppCubit.get(context).getSearchData(value);
                },


              )
              ),

              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return articleItem(searchList[index],context);
                    },
                    separatorBuilder: (context,index)=>separateItem(),
                    itemCount: searchList.length)
                ,

              )


            ],
          ),
        );},
    );
  }
}
