import 'package:ecommerce/components/custom_app_bar.dart';
import 'package:ecommerce/components/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/error_text.dart';
import '../../components/loader.dart';
import '../../utills/constants.dart';
import 'home_card.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "BeautyBarn"),
      backgroundColor: Constants.bgColor,
      body: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
          child: const HomeWidget()
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeBloc controller;

  @override
  void initState() {
    controller = BlocProvider.of<HomeBloc>(context);
    controller.listenScrollEvent();
    controller.fetchProducts(null);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if(state is HomeLoading){
        return const Loader();
      }else if(state is HomeFailed){
        return ErrorText(error: state.error, onRetry: () => controller.fetchProducts(null));
      }else {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: controller.searchController,
                onChanged: (value) async {
                  await controller.fetchProducts(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search...',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                  suffixIcon: IconButton(
                      icon: controller.searchController.text != '' ? const Icon(Icons.close, color: Colors.grey, size: 20) : const Icon(Icons.search, color: Colors.grey, size: 20),
                      onPressed: () async{
                        if(controller.searchController.text != ''){
                          controller.searchController.clear();
                          await controller.fetchProducts(null);
                        }
                      }),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.grey.shade300)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.grey.shade300)
                  ),
                ),
              ),
            ),
            (controller.products.isEmpty) ? NoDataWidget(title: "No products found", onRetry: () => controller.fetchProducts(null), msg: "",) : RefreshIndicator(
                color: Constants.primary,
                backgroundColor: Colors.white,
                onRefresh: () async{
                  await controller.fetchProducts(null);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ListView.separated(
                      controller: controller.scrollController,
                      itemBuilder: (context, index) => HomeCard(
                        product: controller.products[index],
                      ),
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
                      separatorBuilder: (context, pos) => const SizedBox(height: 16,),
                      itemCount: controller.products.length
                  ),
                )
            ),
            Visibility(
              visible: state is HomeMoreLoading,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Constants.primary,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }
    );
  }
}