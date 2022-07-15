import 'package:application1/layout/news_app/cubit/cubit.dart';
import 'package:application1/layout/news_app/cubit/states.dart';
import 'package:application1/shared/components/componants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/news_app/search/search_screen.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/network/remote/dio_helper.dart';

class  NewsLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<NewsCubit,NewsStates>(
        listener: ( buildcontext, state) {  },
        builder: ( context,  state)
        {
          var cubit=NewsCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            title:Text
              ('News App') ,
            actions: [
              IconButton(onPressed:()
              {navigateTo(context, SearchScreen());},
                icon: Icon(Icons.search),),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();
                },
              ),

            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar
            (
            currentIndex: cubit.currentindex,
            onTap: (index)
            {
              cubit.ChangeBottomNavBar(index);
            },
            items: cubit.bottomItems,

          ),

        ); },
    );
  }
}
