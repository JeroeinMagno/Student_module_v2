import 'package:equatable/equatable.dart';

class ChartData extends Equatable {
  final String month;
  final double desktop;

  const ChartData({
    required this.month,
    required this.desktop,
  });

  @override
  List<Object?> get props => [month, desktop];

  ChartData copyWith({
    String? month,
    double? desktop,
  }) {
    return ChartData(
      month: month ?? this.month,
      desktop: desktop ?? this.desktop,
    );
  }
}
