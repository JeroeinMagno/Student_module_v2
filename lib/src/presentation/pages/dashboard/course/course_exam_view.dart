import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseExamView extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseExamView({
    super.key,
    required this.course,
  });

  @override
  State<CourseExamView> createState() => _CourseExamViewState();
}

class _CourseExamViewState extends State<CourseExamView> {
  String selectedTab = 'Strengths';
  String selectedExamType = 'Midterm'; // Add exam type state
  // Sample data for different exam types
  final Map<String, Map<String, dynamic>> examData = {
    'Midterm': {
      'contribution': 0.3,
      'pieData': [
        {'name': 'Programming', 'value': 0.35, 'color': const Color(0xFF2196F3)},
        {'name': 'Theory', 'value': 0.25, 'color': const Color(0xFF4CAF50)},
        {'name': 'Problem Solving', 'value': 0.20, 'color': const Color(0xFFFF9800)},
        {'name': 'Data Structures', 'value': 0.20, 'color': const Color(0xFFF44336)},
      ],
      'barData': [
        {'correct': 0.8, 'mistakes': 0.2},
        {'correct': 0.6, 'mistakes': 0.4},
        {'correct': 0.7, 'mistakes': 0.3},
        {'correct': 0.9, 'mistakes': 0.1},
      ],
    },
    'Final': {
      'contribution': 0.4,
      'pieData': [
        {'name': 'Programming', 'value': 0.30, 'color': const Color(0xFF2196F3)},
        {'name': 'Theory', 'value': 0.30, 'color': const Color(0xFF4CAF50)},
        {'name': 'Problem Solving', 'value': 0.25, 'color': const Color(0xFFFF9800)},
        {'name': 'Data Structures', 'value': 0.15, 'color': const Color(0xFFF44336)},
      ],
      'barData': [
        {'correct': 0.5, 'mistakes': 0.5},
        {'correct': 0.7, 'mistakes': 0.3},
        {'correct': 0.4, 'mistakes': 0.6},
        {'correct': 0.8, 'mistakes': 0.2},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course['name'] ?? 'Course',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              widget.course['code'] ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(              onPressed: () {
                // Navigate back to syllabus view (course detail page)
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              child: Text(
                'View Syllabus',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Professor and Description
            _buildProfessorSection(context),
            
            SizedBox(height: 24.h),
            
            // Exam Analysis Cards
            Row(
              children: [
                Expanded(
                  child: _buildMidtermExamination(context),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildAssessmentMapping(context),
                ),
              ],
            ),
            
            SizedBox(height: 24.h),
              // Exam Type Selector
            _buildExamTypeSelector(context),
            
            SizedBox(height: 24.h),
            
            // Strengths and Weaknesses Section
            _buildStrengthsWeaknessesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prof. ${widget.course['professor'] ?? 'Jane Doe'}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          widget.course['description'] ?? 'An introduction to computer science concepts, history, and problem solving.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
  Widget _buildMidtermExamination(BuildContext context) {
    final currentExamData = examData[selectedExamType]!;
    final contribution = currentExamData['contribution'] as double;
    
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$selectedExamType Examination',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),          Row(
            children: [
              Expanded(
                child: Text(
                  'Contribution to Final Grade',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: selectedExamType == 'Midterm' ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  selectedExamType,
                  style: TextStyle(
                    color: selectedExamType == 'Midterm' ? Colors.red : Colors.blue,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 120.w,
                height: 120.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: CircularProgressIndicator(
                        value: contribution,
                        strokeWidth: 12.w,
                        backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          selectedExamType == 'Midterm' ? Colors.orange : Colors.blue,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(contribution * 100).toInt()}%',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 32.sp,
                          ),
                        ),
                        Text(
                          'Contribution',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }  Widget _buildAssessmentMapping(BuildContext context) {
    final currentExamData = examData[selectedExamType]!;
    final pieData = currentExamData['pieData'] as List<Map<String, dynamic>>;
    final barData = currentExamData['barData'] as List<Map<String, dynamic>>;
    
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assessment Mapping',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),          Text(
            'Intended Learning Outcomes - $selectedExamType Analysis',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: _buildBarChartForAssessment(context, barData, pieData),
          ),
          SizedBox(height: 12.h),
          _buildBarChartLegend(context),
        ],
      ),
    );  }

  Widget _buildBarChartForAssessment(BuildContext context, List<Map<String, dynamic>> barData, List<Map<String, dynamic>> pieData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: barData.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final correct = item['correct']!;
        final mistakes = item['mistakes']!;
        final categoryName = pieData[index]['name'];
        
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [                Expanded(
                  child: SizedBox(
                    width: 32.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: (mistakes * 100).toInt().clamp(1, 100),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.r),
                                topRight: Radius.circular(4.r),
                              ),
                            ),
                            child: mistakes > 0.1 ? Center(
                              child: Text(
                                '${(mistakes * 100).toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ) : null,
                          ),
                        ),
                        Flexible(
                          flex: (correct * 100).toInt().clamp(1, 100),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                            child: correct > 0.1 ? Center(
                              child: Text(
                                '${(correct * 100).toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),                Text(
                  categoryName.toString().length > 8 
                      ? '${categoryName.toString().substring(0, 8)}...'
                      : categoryName.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 9.sp,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }  Widget _buildBarChartLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 3.w),
              Flexible(
                child: Text(
                  'Correct',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 9.sp,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 3.w),
              Flexible(
                child: Text(
                  'Mistakes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 9.sp,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExamTypeSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select Exam Type:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          DropdownButton<String>(
            value: selectedExamType,
            dropdownColor: Theme.of(context).colorScheme.surface,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            underline: Container(
              height: 2,
              color: const Color(0xFF4CAF50),
            ),
            items: examData.keys.map((String examType) {
              return DropdownMenuItem<String>(
                value: examType,
                child: Text(
                  examType,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedExamType = newValue;
                });
              }
            },
          ),
        ],
      ),
    );
  }  Widget _buildStrengthsWeaknessesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        Row(
          children: [
            Flexible(
              child: _buildTabButton('Strengths', selectedTab == 'Strengths'),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: _buildTabButton('Weaknesses', selectedTab == 'Weaknesses'),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        if (selectedTab == 'Strengths') _buildStrengthsContent(context),
        if (selectedTab == 'Weaknesses') _buildWeaknessesContent(context),
      ],
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF4CAF50)
              : Theme.of(context).colorScheme.outline.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected 
                ? Colors.white 
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13.sp,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
  Widget _buildStrengthsContent(BuildContext context) {
    final currentExamData = examData[selectedExamType]!;
    final pieData = currentExamData['pieData'] as List<Map<String, dynamic>>;
    final barData = currentExamData['barData'] as List<Map<String, dynamic>>;
    
    // Find strongest areas based on bar chart data
    List<Map<String, dynamic>> strengths = [];
    for (int i = 0; i < barData.length; i++) {
      final correct = barData[i]['correct'] as double;
      if (correct >= 0.7) { // 70% or more correct
        strengths.add({
          'title': 'ILO: ${pieData[i]['name']}',
          'description': 'Excellent performance: ${(correct * 100).toInt()}% correct. Keep up the good work!',
          'icon': _getIconForCategory(pieData[i]['name'].toString()),
          'percentage': correct,
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Strengths',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Based on $selectedExamType performance analysis.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          if (strengths.isEmpty)
            Text(
              'Keep working hard! Focus on improving your performance to identify strength areas.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...strengths.map((strength) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      strength['icon'] as IconData,
                      color: const Color(0xFF4CAF50),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strength['title'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          strength['description'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'programming':
        return Icons.code;
      case 'theory':
        return Icons.book;
      case 'problem solving':
        return Icons.psychology;
      case 'data structures':
        return Icons.account_tree;
      default:
        return Icons.star;
    }
  }
  Widget _buildWeaknessesContent(BuildContext context) {
    final currentExamData = examData[selectedExamType]!;
    final pieData = currentExamData['pieData'] as List<Map<String, dynamic>>;
    final barData = currentExamData['barData'] as List<Map<String, dynamic>>;
    
    // Find weakest areas based on bar chart data
    List<Map<String, dynamic>> weaknesses = [];
    for (int i = 0; i < barData.length; i++) {
      final correct = barData[i]['correct'] as double;
      if (correct < 0.6) { // Less than 60% correct
        weaknesses.add({
          'title': 'ILO: ${pieData[i]['name']}',
          'description': 'Performance: ${(correct * 100).toInt()}% correct. Focus on improving fundamentals.',
          'icon': Icons.trending_down,
          'percentage': correct,
        });
      }
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas for Improvement',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Based on $selectedExamType performance analysis.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          if (weaknesses.isEmpty)
            Text(
              'Great job! No significant weaknesses identified. Continue with your current study approach.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...weaknesses.map((weakness) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      weakness['icon'] as IconData,
                      color: Colors.orange,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weakness['title'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          weakness['description'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }
}