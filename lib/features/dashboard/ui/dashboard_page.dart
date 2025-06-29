import 'package:flutter/material.dart';
import '../../../components/widgets/student_performance_content.dart';
import '../viewmodel/dashboard_viewmodel.dart';

/// Main Dashboard Page for the Student Module
/// 
/// This page serves as the central hub for student information, displaying:
/// - Student performance overview
/// - Course progress
/// - Recent assessments
/// - Academic trends and analytics
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardViewModel _viewModel;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _viewModel = DashboardViewModel();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      await _viewModel.loadDashboardData();
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Failed to load dashboard data: $e';
        });
      }
    }
  }

  Future<void> _refreshData() async {
    await _loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    // Use the existing StudentPerformanceContent which contains all the dashboard logic
    return const StudentPerformanceContent();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
