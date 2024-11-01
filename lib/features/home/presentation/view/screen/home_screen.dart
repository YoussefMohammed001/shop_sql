import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/helpers/navigators.dart';
import 'package:shop_sql/core/helpers/safe_print.dart';
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/core/routing/routes.dart';
import 'package:shop_sql/features/home/presentation/manager/home_cubit.dart';
import 'package:shop_sql/features/home/presentation/view/widgets/category_dialuge.dart';
import 'package:shop_sql/features/products/products_args.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = HomeCubit();
  TextEditingController categoryController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String search = "";
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
          Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: TextFormField(
                  controller: searchController,
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.all(10.sp),
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)
                    ),
                    labelText: "Category",
                  ),
                  onChanged: (value){
                    safePrint(value);
                    search = value;
                    setState(() {

                    });
                  },
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, HomeState state) {
                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeSuccessState) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Visibility(
                            visible: search.isEmpty || state.categories[index].category.toLowerCase().contains(search.toLowerCase()),
                            child: InkWell(
                              onTap: (){
                                pushNamed(context, Routes.productScreen,
                                arguments: ProductsArgs(
                                  catId: state.categories[index].id,
                                  catName: state.categories[index].category,
                                )
                                );

                              },
                              child: Container(

                                margin: EdgeInsets.all(10.sp),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22.sp,
                                      backgroundColor: Colors.blue,
                                      child: Text(
                                        state.categories[index].id.toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.categories[index].category,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        safePrint(
                                            state.categories[index].id.toString());
                                        showDialog(context: context, builder:
                                        (context){
                                          return AlertDialog(
                                            actions: [
                                              SizedBox(
                                                height: 130,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Are you sure you want to delete ${state.categories[index].category}?"),
                                                    SizedBox(height: 10.h,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(onPressed: (){
                                                            cubit.deleteCategory(
                                                                state.categories[index].id);
                                                            pop(context);
                                                          }, child:
                                                          const Text("Delete")),
                                                        ),
                                                        SizedBox(width: 10.w,),
                                                        Expanded(
                                                          child: ElevatedButton(onPressed: (){
                                                            pop(context);
                                                          }, child:
                                                          const Text("Cancel")),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        CategoryDialoge(
                                          context: context,
                                          onPress: () {
                                            cubit.updateCategory(CategoryModel(
                                                category: categoryController.text,
                                            id: state.categories[index].id
                                            ));
                                            categoryController.clear();
                                            setState(() {});
                                            pop(context);
                                          },
                                          categoryController: categoryController,
                                          formKey: formKey,
                                          title: "Update ${state.categories[index].category} Category",
                                          buttonTitle: "Update",
                                        );
                                        safePrint("press");
                                      },
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Visibility(
                            visible: search.isEmpty || state.categories[index].category.toLowerCase().contains(search.toLowerCase()),

                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.sp,
                                vertical: 5,
                              ),
                              child: const Divider(),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.all(10.sp),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  CategoryDialoge(
                    context: context,
                    onPress: () {
                      cubit.addCategory(
                          CategoryModel(category: categoryController.text));
                      categoryController.clear();
                      setState(() {});
                      pop(context);
                    },
                    categoryController: categoryController,
                    formKey: formKey,
                    title: "Add Category",
                    buttonTitle: "Add",
                  );
                  safePrint("press");
                },
                child: const Icon(Icons.add),
              )),
        ],
      ),
    );
  }
}
