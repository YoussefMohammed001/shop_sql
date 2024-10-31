import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/helpers/safe_print.dart';
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/features/home/presentation/manager/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = HomeCubit();
  TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // bloc builder ==> bloc builder for the state changes in the cubit
  // bloc listener ==> listener for the state changes in the cubit
  // bloc consumer  ==> bloc builder + bloc listener

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getCategories(),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const Column(
            children: [
            ],

          ),

          BlocBuilder<HomeCubit, HomeState>(builder: (BuildContext context, HomeState state) {
            if(state is HomeLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            } else if(state is HomeSuccessState){
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10.sp),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: Colors.blue,
                          child: Text(state.categories[index].id.toString()),
                        ),
                        SizedBox(width: 10.sp,),
                        Text(state.categories[index].category),

                      ],
                    ),
                  );
                },

              );
            }else{
              return SizedBox();
            }
          },
          ),
          Container(
              margin: EdgeInsets.all(10.sp),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(onPressed: () {
                safePrint("press");
                cubit.addCategory(CategoryModel(category: "new category"));
              },
                child: Icon(Icons.add),
              )),

        ],
      ),
    );
  }
}
