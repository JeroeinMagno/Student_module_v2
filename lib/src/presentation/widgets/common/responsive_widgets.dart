import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/responsive_utils.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final EdgeInsetsGeometry? padding;
  final bool enableSafeArea;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.padding,
    this.enableSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: padding ?? context.responsivePadding(),
            child: enableSafeArea 
                ? SafeArea(child: body)
                : body,
          );
        },
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final bool centerContent;
  final double? maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.alignment,
    this.constraints,
    this.centerContent = false,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      width: width,
      height: height,
      alignment: alignment,
      constraints: constraints?.copyWith(
        maxWidth: maxWidth ?? context.responsiveMaxWidth,
      ),
      child: child,
    );

    if (centerContent) {
      content = Center(child: content);
    }

    return content;
  }
}

class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final bool wrapOnSmallScreen;
  final WrapAlignment wrapAlignment;
  final WrapCrossAlignment wrapCrossAlignment;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    this.wrapOnSmallScreen = true,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.center,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    if (children.isNotEmpty) {
      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(width: spacing.w));
        }
      }
    }

    if (wrapOnSmallScreen && context.isMobile) {
      return Wrap(
        alignment: wrapAlignment,
        crossAxisAlignment: wrapCrossAlignment,
        spacing: spacing.w,
        runSpacing: spacing.h,
        children: children,
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    if (children.isNotEmpty) {
      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(height: spacing.h));
        }
      }
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? fixedColumnCount;
  final double? maxCrossAxisExtent;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.fixedColumnCount,
    this.maxCrossAxisExtent,
    this.childAspectRatio = 1.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columnCount = fixedColumnCount ?? context.responsiveColumnCount;
    final crossAxisExtent = maxCrossAxisExtent ?? 
        (MediaQuery.of(context).size.width - (spacing * (columnCount + 1))) / columnCount;

    return GridView.builder(
      padding: padding ?? EdgeInsets.all(spacing.w),
      gridDelegate: fixedColumnCount != null
          ? SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              crossAxisSpacing: spacing.w,
              mainAxisSpacing: runSpacing.h,
              childAspectRatio: childAspectRatio,
            )
          : SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: crossAxisExtent,
              crossAxisSpacing: spacing.w,
              mainAxisSpacing: runSpacing.h,
              childAspectRatio: childAspectRatio,
            ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final VoidCallback? onTap;
  final bool adaptPadding;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.onTap,
    this.adaptPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = adaptPadding
        ? context.responsivePadding(mobile: 12, tablet: 16, desktop: 20)
        : padding;

    Widget card = Card(
      color: backgroundColor,
      elevation: elevation,
      shape: shape,
      margin: margin,
      child: Padding(
        padding: responsivePadding ?? EdgeInsets.zero,
        child: child,
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: card,
      );
    }

    return card;
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final ResponsiveTextType type;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.type = ResponsiveTextType.body,
  });

  const ResponsiveText.headline(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.headline;

  const ResponsiveText.title(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.title;

  const ResponsiveText.body(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.body;

  const ResponsiveText.caption(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.caption;

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle;
    
    switch (type) {
      case ResponsiveTextType.headline:
        baseStyle = ResponsiveTextStyles.getHeadlineStyle(context);
        break;
      case ResponsiveTextType.title:
        baseStyle = ResponsiveTextStyles.getTitleStyle(context);
        break;
      case ResponsiveTextType.body:
        baseStyle = ResponsiveTextStyles.getBodyStyle(context);
        break;
      case ResponsiveTextType.caption:
        baseStyle = ResponsiveTextStyles.getCaptionStyle(context);
        break;
    }

    return Text(
      text,
      style: baseStyle.merge(style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum ResponsiveTextType {
  headline,
  title,
  body,
  caption,
}
