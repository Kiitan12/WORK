import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_style.dart';
import '../../../../../constants/colors.dart';
import '../../../domain/model/task.dart';

// Widget for displaying a task card
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.isTrending = false,
    this.onTap,
  });

  final Task task; // Task object to display details
  final VoidCallback? onTap; // Callback function when the task card is tapped
  final bool isTrending; // Flag to indicate if the task is trending

// Build method to construct the widget
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 236,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: knew,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Display task image using CachedNetworkImage for efficient loading and caching
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: task.imgUrl,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.cause,
                      style: AppStyle.kRegular14.copyWith(color: kGray65),
                    ),
                    // Display task title with custom text style, allowing ellipsis for overflow
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          (isTrending ? 0.4 : 0.5),
                      child: Text(
                        task.title,
                        style: AppStyle.kRegular20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 64,
              child: Text(
                task.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.kRegular12Inter,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: kGray65),
                    SizedBox(
                      width: isTrending
                          ? MediaQuery.of(context).size.width * 0.20
                          : MediaQuery.of(context).size.width * 0.23,
                      child: Text(
                        task.location,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.kRegular10,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.access_time_filled, color: kGray65),
                    const SizedBox(width: 4),
                    Text(task.time, style: AppStyle.kRegular10),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.share, color: kGray65),
                    SizedBox(width: 28),
                    InkWell(
                      child: Icon(Icons.favorite_border, color: kGray65),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
