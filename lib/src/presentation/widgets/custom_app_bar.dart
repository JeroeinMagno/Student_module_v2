import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showMenuButton;
  final List<String>? availableAcademicYears;
  final String? initialAcademicYear;
  final String? initialSemester;
  final Function(String year, String semester)? onPeriodChanged;

  const CustomAppBar({
    super.key,
    this.onMenuPressed,
    required this.title,
    this.showMenuButton = false,
    this.availableAcademicYears,
    this.initialAcademicYear,
    this.initialSemester,
    this.onPeriodChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String selectedAcademicYear;
  late String selectedSemester;

  late List<String> academicYears;
  final List<String> semesters = [
    '1st Semester',
    '2nd Semester',
    'Midyear',
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize academic years from widget or use default
    academicYears = widget.availableAcademicYears ?? _generateDefaultAcademicYears();
    
    // Initialize selected values from widget or use defaults
    selectedAcademicYear = widget.initialAcademicYear ?? academicYears.first;
    selectedSemester = widget.initialSemester ?? 'Midyear';
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update academic years if they changed
    if (widget.availableAcademicYears != oldWidget.availableAcademicYears) {
      academicYears = widget.availableAcademicYears ?? _generateDefaultAcademicYears();
      
      // Ensure selected year is still valid
      if (!academicYears.contains(selectedAcademicYear)) {
        selectedAcademicYear = academicYears.first;
      }
    }
    
    // Update selected values if they changed
    if (widget.initialAcademicYear != oldWidget.initialAcademicYear &&
        widget.initialAcademicYear != null) {
      selectedAcademicYear = widget.initialAcademicYear!;
    }
    
    if (widget.initialSemester != oldWidget.initialSemester &&
        widget.initialSemester != null) {
      selectedSemester = widget.initialSemester!;
    }
  }

  List<String> _generateDefaultAcademicYears() {
    final currentYear = DateTime.now().year;
    return [
      '${currentYear - 1}-$currentYear',
      '$currentYear-${currentYear + 1}',
      '${currentYear + 1}-${currentYear + 2}',
    ];
  }

  void _showAcademicYearDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tempAcademicYear = selectedAcademicYear;
        String tempSemester = selectedSemester;

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Container(
                width: 320.w,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Period',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    
                    // Academic Year Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Academic Year',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: tempAcademicYear,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: academicYears.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(year),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    tempAcademicYear = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Semester Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semester',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: tempSemester,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: semesters.map((String semester) {
                                return DropdownMenuItem<String>(
                                  value: semester,
                                  child: Text(semester),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    tempSemester = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Apply Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(                        onPressed: () {
                          this.setState(() {
                            selectedAcademicYear = tempAcademicYear;
                            selectedSemester = tempSemester;
                          });
                          
                          // Call the callback if provided
                          if (widget.onPeriodChanged != null) {
                            widget.onPeriodChanged!(tempAcademicYear, tempSemester);
                          }
                          
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0, // Remove default spacing
        leading: widget.showMenuButton
            ? IconButton(
                onPressed: widget.onMenuPressed,
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null,
        title: Padding(
          padding: EdgeInsets.only(
            left: widget.showMenuButton ? 0 : 16.w,
            right: 8.w,
          ),
          child: GestureDetector(
            onTap: _showAcademicYearDialog,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'A.Y. $selectedAcademicYear - $selectedSemester',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 12.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}