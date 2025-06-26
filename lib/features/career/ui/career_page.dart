import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../viewmodel/career_viewmodel.dart';
import '../model/skill.dart';
import '../model/career_opportunity.dart';
import '../model/career_profile.dart';

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CareerViewModel(),
      child: const _CareerPageContent(),
    );
  }
}

class _CareerPageContent extends StatefulWidget {
  const _CareerPageContent();

  @override
  State<_CareerPageContent> createState() => _CareerPageContentState();
}

class _CareerPageContentState extends State<_CareerPageContent> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CareerViewModel>().loadCareerData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: _buildTabBarView(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Career & Skills',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Consumer<CareerViewModel>(
            builder: (context, viewModel, child) {
              return AppIconButton(
                icon: const Icon(Icons.refresh),
                onPressed: viewModel.isLoading ? null : () => viewModel.refreshData(),
                size: AppDimensions.iconLG,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Skills'),
          Tab(text: 'Opportunities'),
          Tab(text: 'Profile'),
        ],
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
          color: AppColors.primary.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return Consumer<CareerViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: AppLoading());
        }

        if (viewModel.error != null) {
          return Center(
            child: AppError(
              message: viewModel.error!,
              onRetry: () => viewModel.refreshData(),
            ),
          );
        }

        return TabBarView(
          controller: _tabController,
          children: [
            _buildSkillsTab(viewModel),
            _buildOpportunitiesTab(viewModel),
            _buildProfileTab(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildSkillsTab(CareerViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        children: [
          _buildSkillsOverview(viewModel),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: _buildSkillsList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsOverview(CareerViewModel viewModel) {
    final stats = viewModel.careerStats;
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total Skills',
                    stats['skillsCount'].toString(),
                    AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Average Level',
                    '${(stats['averageSkillLevel'] * 100).round()}%',
                    AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSkillsList(CareerViewModel viewModel) {
    final skillsByCategory = viewModel.skillsByCategory;
    
    if (skillsByCategory.isEmpty) {
      return const AppEmpty(message: 'No skills found');
    }

    return ListView.builder(
      itemCount: skillsByCategory.keys.length,
      itemBuilder: (context, index) {
        final category = skillsByCategory.keys.elementAt(index);
        final skills = skillsByCategory[category]!;
        return _buildSkillsCategory(category, skills);
      },
    );
  }

  Widget _buildSkillsCategory(String category, List<Skill> skills) {
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            ...skills.map((skill) => _buildSkillItem(skill)),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillItem(Skill skill) {
    final color = _getSkillColor(skill.level);
    
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  skill.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppBadge(
                text: skill.levelDescription,
                backgroundColor: color.withOpacity(0.1),
                textColor: color,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: skill.level,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${skill.percentageLevel}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesTab(CareerViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        children: [
          _buildOpportunitiesOverview(viewModel),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: _buildOpportunitiesList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesOverview(CareerViewModel viewModel) {
    final stats = viewModel.careerStats;
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Opportunities Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total',
                    stats['totalOpportunities'].toString(),
                    AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Applied',
                    stats['appliedOpportunities'].toString(),
                    AppColors.warning,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'High Match',
                    stats['highMatchOpportunities'].toString(),
                    AppColors.success,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Avg Match',
                    '${(stats['averageMatchPercentage'] * 100).round()}%',
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunitiesList(CareerViewModel viewModel) {
    if (viewModel.opportunities.isEmpty) {
      return const AppEmpty(message: 'No opportunities found');
    }

    return ListView.builder(
      itemCount: viewModel.opportunities.length,
      itemBuilder: (context, index) {
        return _buildOpportunityCard(viewModel.opportunities[index]);
      },
    );
  }

  Widget _buildOpportunityCard(CareerOpportunity opportunity) {
    final matchColor = _getMatchColor(opportunity.matchPercentage);
    
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: InkWell(
        onTap: () => _showOpportunityDetails(opportunity),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          opportunity.company,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBadge(
                    text: '${(opportunity.matchPercentage * 100).round()}%',
                    backgroundColor: matchColor.withOpacity(0.1),
                    textColor: matchColor,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingSM),
              Row(
                children: [
                  Icon(
                    opportunity.isRemote ? Icons.home : Icons.location_on,
                    size: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    opportunity.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  if (opportunity.salaryRange != null) ...[
                    Icon(
                      Icons.monetization_on,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      opportunity.salaryRange!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
              if (opportunity.applicationStatus != null) ...[
                SizedBox(height: AppDimensions.paddingSM),
                AppBadge(
                  text: _formatApplicationStatus(opportunity.applicationStatus!),
                  backgroundColor: _getApplicationStatusColor(opportunity.applicationStatus!).withOpacity(0.1),
                  textColor: _getApplicationStatusColor(opportunity.applicationStatus!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab(CareerViewModel viewModel) {
    if (viewModel.profile == null) {
      return const Center(child: AppEmpty(message: 'No profile data available'));
    }

    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        children: [
          _buildProfileOverview(viewModel.profile!),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: _buildReadinessAssessment(viewModel.profile!),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOverview(CareerProfile profile) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Career Readiness',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${profile.overallReadinessPercentage}%',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: _getReadinessColor(profile.overallReadinessScore),
                        ),
                      ),
                      Text(
                        'Overall Readiness',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        profile.overallReadinessLevel,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: _getReadinessColor(profile.overallReadinessScore),
                        ),
                      ),
                      Text(
                        'Level',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessAssessment(CareerProfile profile) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Readiness Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Expanded(
              child: ListView.builder(
                itemCount: profile.readinessScores.length,
                itemBuilder: (context, index) {
                  final category = profile.readinessScores.keys.elementAt(index);
                  final score = profile.readinessScores[category]!;
                  return _buildReadinessItem(category, score, profile);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessItem(String category, double score, CareerProfile profile) {
    final color = _getReadinessColor(score);
    final formattedCategory = _formatCategoryName(category);
    
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  formattedCategory,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppBadge(
                text: profile.getReadinessLevel(category),
                backgroundColor: color.withOpacity(0.1),
                textColor: color,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: score,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${profile.getReadinessPercentage(category)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSkillColor(double level) {
    if (level >= 0.8) return AppColors.success;
    if (level >= 0.6) return AppColors.primary;
    if (level >= 0.4) return AppColors.warning;
    return AppColors.error;
  }

  Color _getMatchColor(double percentage) {
    if (percentage >= 0.8) return AppColors.success;
    if (percentage >= 0.6) return AppColors.primary;
    if (percentage >= 0.4) return AppColors.warning;
    return AppColors.error;
  }

  Color _getReadinessColor(double score) {
    if (score >= 0.8) return AppColors.success;
    if (score >= 0.6) return AppColors.primary;
    if (score >= 0.4) return AppColors.warning;
    return AppColors.error;
  }

  Color _getApplicationStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'applied':
        return AppColors.info;
      case 'interview':
        return AppColors.warning;
      case 'accepted':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatApplicationStatus(String status) {
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  String _formatCategoryName(String category) {
    return category
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _showOpportunityDetails(CareerOpportunity opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildOpportunityDetailsModal(opportunity),
    );
  }

  Widget _buildOpportunityDetailsModal(CareerOpportunity opportunity) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
              opportunity.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              opportunity.company,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection('Description', opportunity.description),
                    _buildDetailSection('Location', opportunity.location),
                    if (opportunity.salaryRange != null)
                      _buildDetailSection('Salary Range', opportunity.salaryRange!),
                    _buildDetailSection('Type', _formatApplicationStatus(opportunity.type)),
                    _buildDetailSection('Level', _formatApplicationStatus(opportunity.level)),
                    _buildDetailSection('Match', '${(opportunity.matchPercentage * 100).round()}%'),
                    _buildSkillsSection('Required Skills', opportunity.requiredSkills),
                    if (opportunity.preferredSkills.isNotEmpty)
                      _buildSkillsSection('Preferred Skills', opportunity.preferredSkills),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: opportunity.applicationStatus == null ? 'Apply Now' : 'Applied',
                onPressed: opportunity.applicationStatus == null
                    ? () => _applyToOpportunity(opportunity.id)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(String title, List<String> skills) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: skills.map((skill) => AppBadge(
              text: skill,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              textColor: AppColors.primary,
            )).toList(),
          ),
        ],
      ),
    );
  }

  void _applyToOpportunity(String opportunityId) {
    context.read<CareerViewModel>().applyToOpportunity(opportunityId);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application submitted successfully!')),
    );
  }
}
