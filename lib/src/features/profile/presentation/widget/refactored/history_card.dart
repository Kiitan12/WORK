import 'package:flutter/material.dart';

import '../../../../../constants/app_style.dart';
import '../../../../../constants/colors.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Banchory Health Rally',
                style: AppStyle.kRegular16Inter,
              ),
              Text(
                '2W',
                style: AppStyle.kRegular10,
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, color: kBlueAccent),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33,
                child: Text(
                  'Bridge street, Aberdeen',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.kRegular10,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time_filled, color: kBlueAccent),
              const SizedBox(width: 4),
              Text('2Hrs', style: AppStyle.kRegular10),
            ],
          )
        ],
      ),
    );
  }
}
