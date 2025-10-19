import 'package:ecommerce/components/custom_app_bar.dart';
import 'package:ecommerce/components/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/error_text.dart';
import '../../components/loader.dart';
import '../../utils/constants.dart';
import 'widgets/home_card.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "BeautyBarn"),
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: const HomeWidget(),
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Loader();
        } else if (state is HomeFailed) {
          return ErrorText(
            error: state.error,
            onRetry: () => controller.fetchProducts(null),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  controller: controller.searchController,
                  onChanged: (value) async {
                    await controller.fetchProducts(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Search for skin products',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    suffixIcon: controller.searchController.text != ''
                        ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () async {
                        if (controller.searchController.text != '') {
                          controller.searchController.clear();
                          await controller.fetchProducts(null);
                        }
                      },
                    )
                        : const SizedBox.shrink(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Constants.primary,
                  backgroundColor: Colors.white,
                  onRefresh: () async {
                    await controller.fetchProducts(null);
                  },
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: Text(
                            "Products",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      if (controller.products.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: NoDataWidget(
                            title: "No products found",
                            msg: "",
                            onRetry: () => controller.fetchProducts(null),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                return HomeCard(
                                    product: controller.products[index]);
                              },
                              childCount: controller.products.length,
                            ),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                              controller.computeAspectRatio(context),
                            ),
                          ),
                        ),
                      SliverToBoxAdapter(child: const SizedBox(height: 40)),
                      SliverVisibility(
                        visible: state is HomeMoreLoading,
                        sliver: SliverPadding(
                          padding: const EdgeInsets.only(bottom: 30),
                          sliver: SliverToBoxAdapter(
                            child: Loader(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}