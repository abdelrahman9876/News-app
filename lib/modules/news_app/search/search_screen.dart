import 'package:application1/layout/news_app/cubit/cubit.dart';
import 'package:application1/layout/news_app/cubit/states.dart';
import 'package:application1/shared/components/componants.dart';
import 'package:application1/shared/cubit/cubit.dart';
import 'package:application1/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class  SearchScreen extends StatelessWidget {
var SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>
      ( listener: (context,state){},
      builder: (context,state)
      {
       var list =NewsCubit.get(context).search;
       return Scaffold(
         appBar: AppBar(),
         body: Column
           (
           children: [
             Padding(padding: const EdgeInsets.all(20.0),
             child: defaultFormField
               (controller: SearchController,
                 type: TextInputType.text,
                 onChange: (value)
                 {
                  NewsCubit.get(context).getSearch(value);
                 },
                 validator: (value)
                 {
                   if(value.isEmpty)
                     {return 'search must not be empty';}
                   return null;
                 },
                 label: 'Search',
                 prefix: Icons.search),
             ),
             Expanded(child: articleBuilder(list, context,isSearch: true))
           ],
         ),
       );
      });
  }
}
