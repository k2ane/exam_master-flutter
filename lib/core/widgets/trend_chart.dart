import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QuizTrendChart extends StatelessWidget {
  const QuizTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 获取当前主题颜色，确保深色/亮色模式都好看
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final surfaceColor = colorScheme.surfaceContainer; // 提示框背景
    final textColor = colorScheme.onSurfaceVariant;

    // 2. 模拟一周的数据 (实际开发中这部分应该由外部传入)
    // X轴: 0-6 (周一到周日), Y轴: 分数或答题数
    const List<FlSpot> spots = [
      FlSpot(0, 5), // 周一: 5分
      FlSpot(1, 12), // 周二: 12分
      FlSpot(2, 8), // 周三: 8分
      FlSpot(3, 20), // 周四: 20分 (最高)
      FlSpot(4, 15), // 周五: 15分
      FlSpot(5, 18), // 周六: 18分
      FlSpot(6, 10), // 周日: 10分
    ];

    return AspectRatio(
      aspectRatio: 1.70, // 宽长比，保证图表不会被拉伸变形
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            // 🖱️ 交互配置：触摸提示
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => surfaceColor, // 提示框背景色
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    return LineTooltipItem(
                      '${barSpot.y.toInt()} 分',
                      TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),

            // 📏 网格线配置
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false, // 不画竖线，只画横线更清爽
              horizontalInterval: 5, // 每隔 5 分画一条线
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: colorScheme.outlineVariant.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 5], // 虚线效果
                );
              },
            ),

            // 🏷️ 坐标轴标题配置
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ), // 隐藏右侧
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ), // 隐藏顶部
              // 底部 X 轴 (日期/星期)
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1, // 每个点都显示
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        _getDayName(value.toInt()), // 辅助函数：数字转星期
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 左侧 Y 轴 (数值)
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 5, // 刻度间隔
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(color: textColor, fontSize: 12),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
            ),

            // 🖼️ 边框配置 (通常去掉边框更现代)
            borderData: FlBorderData(show: false),

            // 📉 核心数据：线条配置
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 25, // 根据你的数据最大值调整
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true, // ✅ 平滑曲线
                curveSmoothness: 0.35,
                color: primaryColor, // 线条颜色跟随主题
                barWidth: 3, // 线宽
                isStrokeCapRound: true,

                // 🔴 数据点圆点样式
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: colorScheme.surface, // 圆心是背景色(镂空效果)
                      strokeWidth: 2,
                      strokeColor: primaryColor, // 边框是主色
                    );
                  },
                ),

                // 🌊 线下方的渐变填充
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.3), // 上面深一点
                      primaryColor.withOpacity(0.0), // 下面完全透明
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 辅助函数：把 0-6 映射为中文星期
  String _getDayName(int index) {
    switch (index) {
      case 0:
        return '周一';
      case 1:
        return '周二';
      case 2:
        return '周三';
      case 3:
        return '周四';
      case 4:
        return '周五';
      case 5:
        return '周六';
      case 6:
        return '周日';
      default:
        return '';
    }
  }
}
