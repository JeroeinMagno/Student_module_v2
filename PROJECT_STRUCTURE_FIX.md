# Project Structure Standardization Plan

## Current Issues

1. **Inconsistent Widget Organization**: Some features have `ui/widgets/` directories while others have monolithic page files
2. **Mixed Responsibilities**: Some page files contain both screen logic and individual widget components
3. **Unclear Separation**: Confusion between what should be a "page" vs a "widget" vs a "viewmodel"

## Target Structure

Each feature should follow this consistent pattern:

```
lib/features/[feature_name]/
├── model/                      # Data models
├── viewmodel/                  # Business logic & state management
├── ui/
│   ├── [feature_name]_page.dart    # Main page/screen (navigation entry point)
│   └── widgets/                     # Feature-specific widgets
│       ├── [widget1].dart           # Individual widgets
│       ├── [widget2].dart
│       └── widgets.dart             # Barrel file for widgets
├── domain/                     # (Optional) Domain layer for complex features
├── data/                       # (Optional) Data layer for complex features
└── [feature_name].dart         # Feature barrel file
```

## Implementation Plan

### Phase 1: Auth Feature Modularization
- Extract widgets from `login_screen.dart`
- Create `ui/widgets/` directory
- Separate concerns properly

### Phase 2: Exam Feature Modularization  
- Extract widgets from `exam_page.dart`
- Create `ui/widgets/` directory
- Move complex UI components to separate files

### Phase 3: Chatbot Feature Modularization
- Extract widgets from `chatbot_page.dart`
- Create `ui/widgets/` directory
- Separate message components and input widgets

### Phase 4: Courses Feature Completion
- Create `ui/widgets/` directory
- Extract reusable components from course pages
- Ensure consistency with other features

### Phase 5: Career Feature Cleanup
- Ensure career widgets follow the new pattern
- Update barrel files

### Phase 6: Dashboard Feature Cleanup
- Verify dashboard follows the new pattern
- Update barrel files

### Phase 7: Documentation and Validation
- Update all barrel files
- Create comprehensive documentation
- Validate structure consistency

## Rules and Guidelines

### Page vs Widget vs ViewModel
- **Page**: Main entry point for navigation, handles routing and high-level layout
- **Widget**: Reusable UI components with specific functionality 
- **ViewModel**: Business logic, state management, data handling

### File Naming
- Pages: `[feature_name]_page.dart`
- Widgets: `[descriptive_name]_widget.dart` or `[descriptive_name]_card.dart`
- ViewModels: `[feature_name]_viewmodel.dart`

### Organization
- All widgets for a feature go in `ui/widgets/`
- Each widget has a single responsibility
- Complex widgets can be split into sub-widgets
- Always create barrel files for easy imports
