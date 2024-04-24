import 'dart:math';
// importing necessary flutter packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// importing other required files
import 'package:volun_tek/src/constants/app_style.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/features/home/presentation/widget/refactored/selectable_filter_tag.dart';
import 'package:volun_tek/src/features/home/presentation/widget/search_by_cause_view.dart';

import '../../../../routing/routes.dart';
import '../../application/services/task_services.dart';
import '../provider/task_provider.dart';
import 'refactored/interest.dart';
import 'refactored/task_card.dart';

// Define a StatefulWidget for the home screen
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() =>
      _HomeState(); // Creating a state for the home screen
}

// Define the state class for the home screen
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TaskServices taskServices =
      TaskServices(); // Creating an instance of TaskServices class
  final filters = ['Time', 'Skills']; // Defining filter options

  @override
  void initState() {
    super.initState(); // Calling the super class's initState method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold widget for the app's basic layout structure
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top +
                24), // Adding padding to the top of the screen
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Aligning items to the start of the column
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:
                        28.0), // Spacing items evenly between the main axis
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Spacing items evenly between the main axis
                      children: [
                        const CircleAvatar(
                          // Creating a circular avatar widget
                          radius: 24,
                          backgroundColor:
                              kBlue, // Using a custom color from the constant folder
                          child: Icon(
                              Icons.person), // Adding an icon to the avatar
                        ),
                        InkWell(
                          // Adding an inkwell widget for handling taps
                          onTap: () async {
                            // await taskServices.uploadTask(uploadTaskList).then((value) => print('Task Uploaded'));
                            Navigator.pushNamed(context,
                                notification); // Navigating to the notification screen
                          },
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundColor: kYellow,
                            child: Icon(Icons.notifications_outlined),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Discover', style: AppStyle.kHeading1),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 36,
                      child: TextFormField(
                        // Creating a text form field
                        onTap: () {
                          Navigator.pushNamed(context,
                              search); // Nvigating to the search screen
                        },
                        decoration: InputDecoration(
                          hintText: 'whats your interest today?',
                          hintStyle:
                              AppStyle.kRegular12Inter.copyWith(color: kGray16),
                          filled: true,
                          fillColor: knew,
                          suffixIcon: const Icon(Icons.search, color: kGray16),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          border: AppStyle.kNoBorder,
                          enabledBorder: AppStyle
                              .kNoBorder, // Applying custom border style to the text field
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: kGray16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Consumer(builder: (context, ref, child) {
                      final allTask = ref.watch(getAllTask);

                      return allTask.when(
                        data: (data) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectableFilterTag(
                                    // Custom widget for selectable filter tags
                                    titles: filters, // Passing filter options
                                    onSelectionChanged: (index) {
                                      if (index == 0) {
                                        // arrange by time in ascending order
                                        final sortedData = data
                                            .where(
                                                (task) => task.time.isNotEmpty)
                                            .toList()
                                          ..sort((a, b) => a.time.compareTo(
                                              b.time)); // Sorting data by time
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchByCauseView(
                                                      // Navigating to the search by cause screen
                                                      causes: sortedData,
                                                      title:
                                                          'Filter by Time', // Setting screen title
                                                    )));
                                      } else {}
                                    },
                                  ),
                                  const Icon(Icons.filter_list_rounded)
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search by Cause',
                                    style: AppStyle.kRegular20,
                                  ),
                                  const Icon(Icons.arrow_forward)
                                ],
                              ),
                              GridView.builder(
                                itemCount: data
                                    .where((task) => task.cause.isNotEmpty)
                                    .map((task) => task.cause)
                                    .toSet()
                                    .toList()
                                    .length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 16),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2.0,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  final causes = data
                                      .where((task) => task.cause.isNotEmpty)
                                      .map((task) => task.cause)
                                      .toSet()
                                      .toList();

                                  // add the colors randomly to the causes
                                  const colors = causeColors;
                                  final color =
                                      colors[Random().nextInt(colors.length)];

                                  return Interest(
                                    title: causes[index],
                                    color: color,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchByCauseView(
                                                      causes: data
                                                          .where((task) =>
                                                              task.cause ==
                                                              causes[index]
                                                                  .toString())
                                                          .toList())));
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          return Text('Error: $error');
                        },
                        loading: () => const CircularProgressIndicator(),
                      );
                    }),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending',
                          style: AppStyle.kRegular20,
                        ),
                        const Icon(Icons.arrow_forward)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Consumer(builder: (context, ref, child) {
                final task = ref.watch(getTrendingTask);

                return task.when(
                  data: (data) {
                    return CarouselSlider.builder(
                      itemCount: data.length,
                      options: CarouselOptions(
                        height: 234,
                        viewportFraction: 0.76,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false,
                        autoPlay: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: TaskCard(
                            task: data[index],
                            isTrending: true,
                            onTap: () {
                              ref.read(taskProvider.notifier).state =
                                  data[index];
                              Navigator.pushNamed(context, opportunityView);
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                );
              }),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended',
                          style: AppStyle.kRegular20,
                        ),
                        const Icon(Icons.arrow_forward)
                      ],
                    ),
                    Consumer(builder: (context, ref, child) {
                      final task = ref
                          .watch(getAllTask); // Watching a provider for changes

                      return task.when(
                        // Handling different states of the provider
                        data: (data) {
                          return ListView.separated(
                            itemCount: data.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TaskCard(
                                task: data[index],
                                onTap: () {
                                  ref.read(taskProvider.notifier).state =
                                      data[index];
                                  Navigator.pushNamed(context,
                                      opportunityView); // Navigating to the opporrtunityview page
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 20);
                            },
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) {
                          return Text('Error: $error');
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
