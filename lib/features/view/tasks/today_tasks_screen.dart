import 'package:flutter/material.dart';
import 'package:mvvmproject/core/widgets/task_card.dart';
import 'package:mvvmproject/core/widgets/filter_modal.dart';
import 'package:mvvmproject/core/utils/app_colors.dart';
import '../../../core/utils/app_assets.dart';

class TodayTasksScreen extends StatefulWidget {
  const TodayTasksScreen({super.key});

  @override
  State<TodayTasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TodayTasksScreen> {
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 23),

              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 30),

              // Results header
              _buildResultsHeader(),
              const SizedBox(height: 27),

              // Tasks List
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    TaskCard(
                      task: 'Go to supermarket to buy some milk & eggs',
                      status: 'In Progress',
                      statusColor: AppColors.black,
                      iconColor: AppColors.black,
                      icon: AppAssets.workTaskIcon,
                      StatusContainerColor: Color(0xFFCEEBDC),
                    ),
                    TaskCard(
                      task: 'Go to supermarket to buy some milk & eggs',
                      status: 'Done',
                      statusColor: AppColors.white,
                      iconColor: AppColors.black,
                      icon: AppAssets.workTaskIcon,
                      StatusContainerColor: AppColors.green,
                    ),
                    TaskCard(
                      task: 'Add new feature for Do It app and commit it',
                      status: 'Done',
                      statusColor: AppColors.white,
                      iconColor: AppColors.pink,
                      icon: AppAssets.homeTaskIcon,
                      StatusContainerColor: AppColors.green,
                    ),
                    TaskCard(
                      task: 'Improve my English skills by trying to speak',
                      status: 'Missed',
                      statusColor: AppColors.white,
                      iconColor: AppColors.green,
                      icon: AppAssets.PersonIcon,
                      StatusContainerColor: AppColors.statusMissed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterModal(context),
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.menu),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildResultsHeader() {
    return const Row(
      children: [
        Text(
          'Results',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '4',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
