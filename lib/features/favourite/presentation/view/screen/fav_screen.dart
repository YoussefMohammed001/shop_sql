import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/core/widgets/note_item.dart';
import 'package:shop_sql/features/favourite/manager/favorite_cubit.dart';

class FavScreen extends StatefulWidget {
  FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final cubit = FavoriteCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getLineVoice(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if(state is GetCartLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is GetCartSuccess){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.lineVoices.length,
                    itemBuilder: (BuildContext context, int index) {
                   return   Container(
                     margin: EdgeInsets.all(10.sp),
                     padding: EdgeInsets.all(15.sp),
                     decoration:BoxDecoration(
                       color: Colors.grey[200],
                       borderRadius: BorderRadius.circular(10.r),
                     ),
                     child: Row(
                       children: [
                         CircleAvatar(
                           child: Text(state.lineVoices[index].id.toString()),
                         ),
                         SizedBox(
                           width: 10.w,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("product price: "+state.lineVoices[index].price.toString()),
                             Text("product id: "+state.lineVoices[index].productId.toString()),
                           ],
                         ),
                       const Spacer(),
                         Text("quantity: "+state.lineVoices[index].quantity.toString()),
                       ],
                     ),
                   );
                    },
                  
                  ),
                ),

                ElevatedButton(onPressed: (){

                }, child: Text("Confirm"))
              ],
            );
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
