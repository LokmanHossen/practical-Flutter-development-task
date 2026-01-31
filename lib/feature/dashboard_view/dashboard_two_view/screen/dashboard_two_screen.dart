import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/controller/dashboard_two_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/bottom_grid_view.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/data_type_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/widget/power_card.dart';

class DashboardTwoScreen extends StatelessWidget {
  const DashboardTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}

class DashboardTwoContent extends StatelessWidget {
  const DashboardTwoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecondPageController());
    final ScrollController scrollController = ScrollController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFB6B8D0), width: 1.5),
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
                const Text(
                  'Electricity',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(color: Color(0xFF979797)),
                const SizedBox(height: 14),
                const PowerChart(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C99B8).withValues(alpha: 0.2),
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
                  () => SizedBox(
                    height: 280, // Fixed height for the scrollable area
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thickness: WidgetStateProperty.all(6.0),
                        thumbColor: WidgetStateProperty.all(const Color(0xFF0096FC)),
                        trackColor: WidgetStateProperty.all(const Color(0xFFE0E0E0)),
                        trackBorderColor: WidgetStateProperty.all(const Color(0xFFB6B8D0)),
                        radius: const Radius.circular(10),
                        thumbVisibility: WidgetStateProperty.all(true),
                        minThumbLength: 2,
                        mainAxisMargin: 120,
                        trackVisibility: WidgetStateProperty.all(true),
                        interactive: true,
                      ),
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        
                        thickness: 6.0,
                        radius: const Radius.circular(10),
                        interactive: true,
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: controller.energyDataList.length,
                          itemBuilder: (context, index) {
                            return DataTypeCard(data: controller.energyDataList[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Obx(
                //   () => 
                  
                  
                  
                //   Column(
                //     children: controller.energyDataList
                //         .map((data) => DataTypeCard(data: data))
                //         .toList(),
                //   ),
                // ),
                // const SizedBox(height: 16),
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
                color: isSelected ? Colors.transparent : const Color(0xFFB6B8D0),
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF646984),
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
              color: isSelected ? Colors.white : const Color(0xFF646984),
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