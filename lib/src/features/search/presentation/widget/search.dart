import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volun_tek/src/features/home/presentation/widget/refactored/task_card.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import '../../../home/domain/model/task.dart';

// Widget for the search screen
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String name; // Variable to store the search keyword
  late Stream<QuerySnapshot<Map<String, dynamic>>>
      _tasksStream; // Stream to fetch tasks from Firestore

  @override
  void initState() {
    super.initState();
    name = ''; // Initialize the search keyword
    // Initialize the stream to fetch tasks from Firestore
    _tasksStream =
        FirebaseFirestore.instance.collection('trendingTasks').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextFormField(
                autofocus: true,
                onChanged: (value) {
                  setState(() => name = value); // Update the search keyword
                },
                decoration: InputDecoration(
                  hintText: 'What\'s your interest today?',
                  hintStyle: AppStyle.kRegular12.copyWith(color: kGray16),
                  filled: true,
                  fillColor: knew,
                  suffixIcon: const Icon(Icons.search, color: kGray16),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: AppStyle.kNoBorder,
                  enabledBorder: AppStyle.kNoBorder,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kGray16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    _tasksStream, // Stream to listen for changes in tasks data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Loading indicator while fetching data
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'Error: ${snapshot.error}'), // Error message if data fetching fails
                    );
                  } else {
                    final data = snapshot.data?.docs
                            .map((doc) => Task.fromJson(doc.data()))
                            .toList() ??
                        []; // Convert fetched data to Task objects

                    final filteredTasks = data
                        .where((task) =>
                            task.title
                                .toLowerCase()
                                .contains(name.toLowerCase()) ||
                            task.cause.toLowerCase().contains(name
                                .toLowerCase())) // Filter tasks based on search keyword
                        .toList();

                    return filteredTasks.isEmpty
                        ? const Center(
                            child: Text(
                                'No results found')) // Display message if no results found
                        : ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredTasks.length,
                            itemBuilder: (context, index) => TaskCard(
                                task: filteredTasks[
                                    index]), // Display filtered tasks
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
