import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../model/exam.dart';

/// Modal for showing exam details
class ExamDetailsModal extends StatelessWidget {
  final Exam exam;

  const ExamDetailsModal({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusXL),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Text(
              exam.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            _buildDetailRow('Course', '${exam.courseCode} - ${exam.courseName}'),
            _buildDetailRow('Type', exam.type),
            _buildDetailRow('Date', exam.formattedDate),
            _buildDetailRow('Status', _formatStatus(exam.status)),
            if (exam.score != null) ...[
              _buildDetailRow('Score', '${exam.score}/${exam.maxScore}'),
              _buildDetailRow('Percentage', '${exam.percentage?.toStringAsFixed(1)}%'),
            ],
            if (exam.grade != null)
              _buildDetailRow('Grade', exam.grade.toString()),
            _buildDetailRow('Weight', '${exam.weight}%'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }
}
