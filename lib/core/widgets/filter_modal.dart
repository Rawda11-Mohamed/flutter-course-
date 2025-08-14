// filter_modal.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Category
            _buildSectionHeader('Category'),
            _buildFilterChips(
              ['All', 'Work', 'Home', 'Personal'],
              selected: 'All',
            ),
            const SizedBox(height: 24),

            // Status
            _buildSectionHeader('Status'),
            _buildFilterChips(
              ['All', 'In Progress', 'Missed', 'Done'],
              selected: 'All',
            ),
            const SizedBox(height: 24),

            // Date & Time
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey),
                  SizedBox(width: 16),
                  Text(
                    '30 June, 2022',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '10:00 pm',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Filter',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lexend Deca',
      ),
    );
  }

  Widget _buildFilterChips(List<String> options, {required String selected}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: options.map((option) {
          final isSelected = option == selected;
          Color bgColor = isSelected ? AppColors.green : Colors.grey[200]!;
          Color textColor = isSelected ? Colors.white : Colors.black;

          if (option == 'Missed' && isSelected) {
            bgColor = Colors.red;
            textColor = Colors.white;
          } else if (option == 'In Progress' && isSelected) {
            bgColor = const Color(0xFFCEEBDC); // light green
            textColor = AppColors.black;
          } else if (option == 'Done' && isSelected) {
            bgColor = AppColors.green;
            textColor = Colors.white;
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lexend Deca',
                color: textColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}