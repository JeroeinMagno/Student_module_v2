import 'package:flutter/material.dart';
import '../../../data/services/centralized_data_service.dart';

/// Example widget demonstrating how to use CentralizedDataService
/// This shows how the data is now separated from UI components
class CentralizedDataDemo extends StatefulWidget {
  const CentralizedDataDemo({super.key});

  @override
  State<CentralizedDataDemo> createState() => _CentralizedDataDemoState();
}

class _CentralizedDataDemoState extends State<CentralizedDataDemo> {
  final CentralizedDataService _dataService = CentralizedDataService();
  Map<String, dynamic>? studentInfo;
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> assessments = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // Load all data using centralized service
      final results = await Future.wait([
        _dataService.getStudentInfo(),
        _dataService.getCourses(),
        _dataService.getRecentAssessments(),
      ]);

      setState(() {
        studentInfo = results[0] as Map<String, dynamic>;
        courses = results[1] as List<Map<String, dynamic>>;
        assessments = results[2] as List<Map<String, dynamic>>;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _switchToApiData() {
    setState(() {
      _dataService.enableApiData();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('API data enabled (will show error until backend is ready)'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _switchToMockData() {
    setState(() {
      _dataService.enableMockData();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mock data enabled'),
        backgroundColor: Colors.green,
      ),
    );
    _loadData();
  }

  void _printConfiguration() {
    _dataService.printCurrentConfiguration();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Configuration printed to console. API: ${_dataService.isUsingApiData}, Test User: ${_dataService.isUsingTestUser}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centralized Data Demo'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Configuration Controls
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Source Configuration',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('API Data: ${_dataService.isUsingApiData}'),
                  Text('Test User: ${_dataService.isUsingTestUser}'),
                  Text('User ID: ${_dataService.currentUserId}'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: _switchToMockData,
                        child: const Text('Use Mock Data'),
                      ),
                      ElevatedButton(
                        onPressed: _switchToApiData,
                        child: const Text('Use API Data'),
                      ),
                      ElevatedButton(
                        onPressed: _printConfiguration,
                        child: const Text('Print Config'),
                      ),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Reload Data'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Data Display
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error loading data',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                error!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Student Info
                            _buildDataCard(
                              'Student Information',
                              Icons.person,
                              [
                                'Name: ${studentInfo?['name'] ?? 'N/A'}',
                                'SR Code: ${studentInfo?['srCode'] ?? 'N/A'}',
                                'Email: ${studentInfo?['email'] ?? 'N/A'}',
                                'Program: ${studentInfo?['program'] ?? 'N/A'}',
                                'GPA: ${studentInfo?['gpa'] ?? 'N/A'}',
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Courses
                            _buildDataCard(
                              'Enrolled Courses (${courses.length})',
                              Icons.school,
                              courses.map((course) => 
                                '${course['code']}: ${course['title']} - ${course['instructor']}',
                              ).toList(),
                            ),

                            const SizedBox(height: 16),

                            // Recent Assessments
                            _buildDataCard(
                              'Recent Assessments (${assessments.length})',
                              Icons.assignment,
                              assessments.map((assessment) => 
                                '${assessment['courseCode']} - ${assessment['type']}: ${assessment['score']} (${assessment['date']})',
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(String title, IconData icon, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue.shade600),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $item',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
