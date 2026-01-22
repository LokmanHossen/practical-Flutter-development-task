import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_one_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/controller/dashboard_two_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/models/dashboard_two_model.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/data_type_card.dart';

class DashboardTwoScreen extends StatelessWidget {
  const DashboardTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecondPageController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          '2nd Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Badge(
              smallSize: 11,
              child: Image.asset(IconPath.notificationIcon, height: 24),
            ),

            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Navigate Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => DashboardOneScreen());
                },

                //  controller.navigateToFirstPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1st Page Navigate',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      _buildTab('Summery', 0, controller),
                      _buildTab('SLD', 1, controller),
                      _buildTab('Data', 2, controller),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Content Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Electricity',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),

                    // Power Chart
                    const PowerChart(),
                    const SizedBox(height: 20),

                    // Source/Load Toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: _buildSourceButton(
                                'Source',
                                controller.selectedSource.value == 'Source',
                                () => controller.toggleSource('Source'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSourceButton(
                                'Load',
                                controller.selectedSource.value == 'Load',
                                () => controller.toggleSource('Load'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Data Type Cards
                    Obx(
                      () => Column(
                        children: controller.energyDataList
                            .map((data) => DataTypeCard(data: data))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: controller.actionItems.length,
                  itemBuilder: (context, index) {
                    return ActionButton(item: controller.actionItems[index]);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index, SecondPageController controller) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00B4D8) : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00B4D8) : Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ==================== widgets/power_chart.dart ====================
class PowerChart extends StatelessWidget {
  const PowerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle (light blue)
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB3E5FC), width: 20),
            ),
          ),
          // Foreground arc (dark blue)
          SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 20,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF00B4D8),
              ),
            ),
          ),
          // Center text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Power',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 4),
              const Text(
                '5.53 kw',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==================== widgets/data_type_card.dart ====================

// ==================== widgets/action_button.dart ====================
class ActionButton extends StatelessWidget {
  final ActionItem item;

  const ActionButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.snackbar(
              'Action',
              '${item.title} clicked',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 1),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.icon, color: item.color, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
