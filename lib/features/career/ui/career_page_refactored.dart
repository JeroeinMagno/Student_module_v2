import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../viewmodel/career_viewmodel.dart';
import '../model/career_opportunity.dart';
import 'widgets/skills_overview_card.dart';
import 'widgets/opportunities_overview_card.dart';
import 'widgets/opportunity_card.dart';
import 'widgets/career_profile_overview_card.dart';
import 'widgets/skills_category_card.dart';
import 'widgets/readiness_assessment_card.dart';
import 'widgets/opportunity_details_modal.dart';

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
          SkillsOverviewCard(careerStats: viewModel.careerStats),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: _buildSkillsList(viewModel),
          ),
        ],
      ),
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
        return SkillsCategoryCard(
          category: category,
          skills: skills,
        );
      },
    );
  }

  Widget _buildOpportunitiesTab(CareerViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        children: [
          OpportunitiesOverviewCard(careerStats: viewModel.careerStats),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: _buildOpportunitiesList(viewModel),
          ),
        ],
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
        final opportunity = viewModel.opportunities[index];
        return OpportunityCard(
          opportunity: opportunity,
          onTap: () => _showOpportunityDetails(opportunity),
        );
      },
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
          CareerProfileOverviewCard(profile: viewModel.profile!),
          SizedBox(height: AppDimensions.paddingMD),
          Expanded(
            child: ReadinessAssessmentCard(profile: viewModel.profile!),
          ),
        ],
      ),
    );
  }

  void _showOpportunityDetails(CareerOpportunity opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OpportunityDetailsModal(opportunity: opportunity),
    );
  }
}
