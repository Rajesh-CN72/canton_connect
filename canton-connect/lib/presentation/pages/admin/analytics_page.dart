import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedTimeRange = 'week';
  String _selectedChartType = 'revenue';

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.currentLanguage == 'zh';

    return Scaffold(
      appBar: AdminAppBar(
        title: isChinese ? '数据分析' : 'Analytics',
        showBackButton: true,
        currentLanguage: languageProvider.currentLanguage,
        onLanguageChanged: (newLanguage) {
          languageProvider.setLanguageByCode(newLanguage);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeRangeFilter(isChinese),
            const SizedBox(height: 20),
            _buildKeyMetrics(isChinese),
            const SizedBox(height: 20),
            _buildChartTypeSelector(isChinese),
            const SizedBox(height: 20),
            _buildSimpleChart(isChinese),
            const SizedBox(height: 20),
            _buildAdditionalAnalytics(isChinese),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeFilter(bool isChinese) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isChinese ? '分析概览' : 'Analytics Overview',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: _selectedTimeRange,
          items: [
            DropdownMenuItem(value: 'week', child: Text(isChinese ? '本周' : 'This Week')),
            DropdownMenuItem(value: 'month', child: Text(isChinese ? '本月' : 'This Month')),
            DropdownMenuItem(value: 'year', child: Text(isChinese ? '今年' : 'This Year')),
          ],
          onChanged: (value) => setState(() => _selectedTimeRange = value!),
        ),
      ],
    );
  }

  Widget _buildKeyMetrics(bool isChinese) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildMetricCard(isChinese ? '总收入' : 'Total Revenue', '¥8,450', '+12.5%', Colors.green, Icons.attach_money),
        _buildMetricCard(isChinese ? '总订单' : 'Total Orders', '162', '+8.3%', Colors.blue, Icons.shopping_cart),
        _buildMetricCard(isChinese ? '平均订单价值' : 'Average Order Value', '¥52.15', '+4.2%', Colors.purple, Icons.trending_up),
        _buildMetricCard(isChinese ? '新客户' : 'New Customers', '28', '+15.8%', Colors.orange, Icons.people),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String change, Color color, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Text(change, style: TextStyle(color: change.startsWith('+') ? Colors.green : Colors.red, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTypeSelector(bool isChinese) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChartChip(isChinese ? '收入' : 'Revenue', 'revenue'),
          const SizedBox(width: 8),
          _buildChartChip(isChinese ? '订单' : 'Orders', 'orders'),
          const SizedBox(width: 8),
          _buildChartChip(isChinese ? '客户' : 'Customers', 'customers'),
        ],
      ),
    );
  }

  Widget _buildChartChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedChartType == value,
      onSelected: (selected) => setState(() => _selectedChartType = value),
    );
  }

  Widget _buildSimpleChart(bool isChinese) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getChartTitle(isChinese),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _buildChartContent(isChinese),
            ),
          ],
        ),
      ),
    );
  }

  String _getChartTitle(bool isChinese) {
    switch (_selectedChartType) {
      case 'revenue': return isChinese ? '收入趋势' : 'Revenue Trend';
      case 'orders': return isChinese ? '订单统计' : 'Order Statistics';
      case 'customers': return isChinese ? '客户增长' : 'Customer Growth';
      default: return isChinese ? '数据分析' : 'Analytics';
    }
  }

  Widget _buildChartContent(bool isChinese) {
    // Simple bar chart implementation
    final data = [1200, 1800, 1500, 2200, 2800, 3500, 3200];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(data.length, (index) {
        final height = (data[index] / 3500) * 150;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(labels[index], style: const TextStyle(fontSize: 12)),
          ],
        );
      }),
    );
  }

  Widget _buildAdditionalAnalytics(bool isChinese) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildAdditionalMetric(isChinese ? '转化率' : 'Conversion Rate', '12.8%', Icons.trending_up, Colors.green),
        _buildAdditionalMetric(isChinese ? '客单价' : 'Customer Value', '¥68.50', Icons.attach_money, Colors.blue),
        _buildAdditionalMetric(isChinese ? '复购率' : 'Repeat Rate', '42.3%', Icons.repeat, Colors.purple),
        _buildAdditionalMetric(isChinese ? '满意度' : 'Satisfaction', '4.8/5', Icons.star, Colors.orange),
      ],
    );
  }

  Widget _buildAdditionalMetric(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
