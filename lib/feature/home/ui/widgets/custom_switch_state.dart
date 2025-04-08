import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchState extends StatefulWidget {
  const CustomSwitchState({Key? key}) : super(key: key);

  @override
  _CustomSwitchStateState createState() => _CustomSwitchStateState();
}

class _CustomSwitchStateState extends State<CustomSwitchState> {
  // List of button labels
  final List<String> buttonLabels = ["Pending", "Approved", "InProgress", "Done"];

  // Currently selected button index
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: const Color(0xff1E1E1E),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(buttonLabels.length, (index) {
            return _buildButton(
              label: buttonLabels[index],
              isSelected: selectedIndex == index,
              onTap: () => setState(() {
                selectedIndex = index; // Update the selected index
              }),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32.h,
        width: 100.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2CF00) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
