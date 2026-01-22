import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/controller/dashboard_two_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/bottom_grid_view.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/data_type_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/power_card.dart';
import 'package:scube_app/routes/app_routes.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              _buildNavigateButton(),
          
              const SizedBox(height: 16),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFB6B8D0), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            _buildTab('Summery', 0, controller),
                            _buildTab('SLD', 1, controller),
                            _buildTab('Data', 2, controller),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
          
                      Text(
                        'Electricity',
                        style: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(color: Color(0xFF979797)),
          
                      const SizedBox(height: 14),
                      const PowerChart(),
                      const SizedBox(height: 20),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF6C99B8).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                _buildSourceButton(
                                  'Source',
                                  controller.selectedSource.value == 'Source',
                                  () => controller.toggleSource('Source'),
                                ),
                                _buildSourceButton(
                                  'Load',
                                  controller.selectedSource.value == 'Load',
                                  () => controller.toggleSource('Load'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          
                      const SizedBox(height: 20),
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
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.8,
                    ),
                    itemCount: controller.actionItems.length,
                    itemBuilder: (context, index) {
                      return BottomGridView(item: controller.actionItems[index]);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigateButton() {
    return InkWell(
      onTap: () => Get.toNamed(AppRoute.dashboardOneScreen),

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF00C0E8),

          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '1st Page Navigate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0096FC) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.transparent : Color(0xFFB6B8D0),
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF646984),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0096FC) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF646984),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
