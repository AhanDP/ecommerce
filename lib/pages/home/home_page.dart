import 'package:ecommerce/components/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/error_text.dart';
import '../../components/loader.dart';
import '../../navigation/navigation.dart';
import '../../utills/constants.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigation.instance.goBack();
          },
          icon: Icon(Icons.keyboard_backspace_rounded, color: Constants.primaryTextColor,),
        ),
        title: Text("BeautyBarn",style: TextStyle(color: Constants.primaryTextColor, fontSize: 20, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade50,
      body: BlocProvider<TruckVtsBloc>(
          create: (context) => TruckVtsBloc(),
          child: const HomeWidget()
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _TruckStatusWidgetState();
}

class _TruckStatusWidgetState extends State<HomeWidget> {
  late TruckVtsBloc controller;

  @override
  void initState() {
    controller = BlocProvider.of<TruckVtsBloc>(context);
    controller.listenScrollEvent();
    controller.fetchTruckVts(null);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TruckVtsBloc, TruckVtsState>(builder: (context, state) {
      if(state is TruckVtsLoading){
        return const Loader();
      }else if(state is TruckVtsFailed){
        return ErrorText(error: state.error, onRetry: () => controller.fetchTruckVts(null));
      }else {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: controller.searchController,
                onChanged: (value) async {
                  await controller.fetchTruckVts(value);
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
                          await controller.fetchTruckVts(null);
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
            (controller.products.isEmpty) ? NoDataWidget(text: "No truck vts found", onRetry: () => controller.fetchTruckVts(null)) : RefreshIndicator(
                color: Constants.primary,
                backgroundColor: Colors.white,
                onRefresh: () async{
                  await controller.fetchTruckVts(null);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ListView.separated(
                      controller: controller.scrollController,
                      itemBuilder: (context, index) => TruckVtsCard(
                        truckVtsItem: controller.products[index],
                      ),
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
                      separatorBuilder: (context, pos) => const SizedBox(height: 16,),
                      itemCount: controller.products.length
                  ),
                )
            ),
            Visibility(
              visible: state is TruckVtsMoreLoading,
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