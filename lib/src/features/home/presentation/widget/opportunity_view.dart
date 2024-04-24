import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volun_tek/globals.dart';
import 'package:volun_tek/src/common_widgets/tek_elevated_button.dart';
import 'package:volun_tek/src/constants/app_style.dart';

import '../../../../constants/colors.dart';
import '../../../../routing/routes.dart';
import '../../../profile/presentation/provider/user_provider.dart';
import '../provider/task_provider.dart';

class OpportunityView extends StatefulWidget {
  const OpportunityView({
    super.key,
  });

  @override
  State<OpportunityView> createState() => _OpportunityViewState();
}

class _OpportunityViewState extends State<OpportunityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final task = ref.watch(taskProvider);
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: kBlueAccent,
                        border: Border(
                          bottom: BorderSide(
                            color: kGray85,
                            width: 1,
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: task.imgUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '10 volunteers showed interest',
                style: AppStyle.kRegular12Inter,
              ),
              const SizedBox(height: 20),
              const Divider(color: kBlueAccent),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppStyle.kRegular20.copyWith(fontSize: 25),
                    ),
                    Text(task.cause, style: AppStyle.kRegular12Inter),
                    const SizedBox(height: 28),
                    TekElevatedButton(
                      title: 'Show Interest',
                      onPressed: () =>
                          Navigator.pushNamed(context, interestForm),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            final auth = FirebaseAuth.instance;
                            // save the task title to the user's favorite list
                            // if favorites field doesn't exist, create it or update it if it does
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .update({
                              'favorites': FieldValue.arrayUnion([task.id])
                            });

                            // create isFavorite field for each user in the task collection
                            FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(task.id)
                                .update({
                              'favorites':
                                  FieldValue.arrayUnion([auth.currentUser!.uid])
                            });
                            ref.refresh(getFavoritesProvider);
                          },
                          icon: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(task.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                // Check if the snapshot has data
                                if (!snapshot.hasData) {
                                  final data = snapshot.data!.data()
                                      as Map<String, dynamic>;

                                  return Icon(
                                    data['favorites'].contains(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: kBlueAccent,
                                  );
                                }
                                return const Icon(Icons.favorite_border);
                              }),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            final auth = FirebaseAuth.instance;
                            // // remove the task title from the user's favorite list
                            // FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(auth.currentUser!.uid)
                            //     .update({
                            //   'favorites': FieldValue.arrayRemove([task.title])
                            // });
                            // // remove isFavorite field for each user in the task collection
                            FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(task.id)
                                .update({
                              'favorites': FieldValue.arrayRemove(
                                  [auth.currentUser!.uid])
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .update({
                              'favorites': FieldValue.arrayRemove([task.id])
                            });

                            ref.refresh(getFavoritesProvider);
                          },
                          child: Text('Save for later',
                              style: AppStyle.kRegular12Inter),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      task.description,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => launchMaps(context, task.location),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: kBlueAccent),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  task.location,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.kRegular10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled,
                                color: kBlueAccent),
                            const SizedBox(width: 4),
                            Text(task.time, style: AppStyle.kRegular10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Divider(color: kBlueAccent),
              const SizedBox(height: 32),
              Text(
                'Rate this opportunity',
                style: AppStyle.kRegular10.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 18),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    print(data['ratings']);

                    List<dynamic> ratings = data['ratings'] ?? [];

                    ratings = ratings
                        .where((rating) =>
                            rating['taskId'] == task.id &&
                            rating['taskId'] == null)
                        .toList();

                    return RatingBar(
                      initialRating:
                          ratings.isEmpty ? 0 : ratings[0]['rating'].toDouble(),
                      itemSize: 24,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: kBlueAccent),
                        half: const Icon(Icons.favorite, color: kBlueAccent),
                        empty: const Icon(Icons.star_border_outlined,
                            color: kBlueAccent),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        final auth = FirebaseAuth.instance;
                        final userDocRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(auth.currentUser!.uid);
                        final rate = {
                          'rating': rating,
                          'taskId': task.id,
                        };

                        userDocRef.get().then((docSnapshot) {
                          if (docSnapshot.exists) {
                            final data = docSnapshot.data();
                            final ratings = data?['ratings'] ?? [];

                            // Check if the task ID exists in the ratings array
                            final taskIndex = ratings.indexWhere(
                                (rating) => rating['taskId'] == task.id);

                            if (taskIndex != -1) {
                              ratings[taskIndex]['rating'] = rating;
                              userDocRef.update({'ratings': ratings}).then((_) {
                                print('Rating updated successfully!');
                              }).catchError((error) {
                                print('Failed to update rating: $error');
                              });
                            } else {
                              // Task ID doesn't exist in the array, add the new rating
                              userDocRef.update({
                                'ratings': FieldValue.arrayUnion([rate])
                              }).then((_) {
                                print('Rating added successfully!');
                              }).catchError((error) {
                                print('Failed to add rating: $error');
                              });
                            }
                          } else {
                            print('User document does not exist.');
                          }
                        }).catchError((error) {
                          print('Error getting user document: $error');
                        });
                      },
                    );
                  }),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Future<void> launchMaps(BuildContext context, String address) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      snackBarKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Could not launch Google Maps.'),
        ),
      );
    }
  }
}
