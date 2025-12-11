import 'package:flutter/material.dart';

import '../report.dart';
import '../utilities.dart';

class MissingPersonCard extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  final String time;
  const MissingPersonCard({
    super.key,
    required this.name,
    required this.description,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Report(
              name: name,
              description: description,
              location: location,
              time: time,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person,
                  color: AppColors.black.withOpacity(0.3), size: 50),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 12, color: AppColors.black.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14, color: AppColors.black.withOpacity(0.4),),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.black.withOpacity(0.5),),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 14, color: AppColors.black.withOpacity(0.4),),
                    const SizedBox(width: 4),
                    Text(time,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black.withOpacity(0.6),),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}