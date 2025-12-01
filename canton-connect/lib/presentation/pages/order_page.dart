// lib/presentation/pages/order_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/providers/language_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Helper method to create colors with opacity without using deprecated methods
  Color _withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final currentLanguage = languageProvider.isChinese ? 'zh' : 'en';
        
        return Scaffold(
          backgroundColor: const Color(AppConstants.backgroundColorValue),
          body: Column(
            children: [
              _buildCustomHeader(context, currentLanguage, languageProvider),
              Expanded(
                child: _buildContent(context, currentLanguage),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomHeader(BuildContext context, String currentLanguage, LanguageProvider languageProvider) {
    return Container(
      color: const Color(AppConstants.primaryColorValue),
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
              Text(
                currentLanguage == 'zh' ? '我的订单' : 'My Orders',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String currentLanguage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderStatusSection(currentLanguage),
          const SizedBox(height: 24),
          _buildActiveOrdersSection(currentLanguage),
          const SizedBox(height: 24),
          _buildOrderHistorySection(currentLanguage),
        ],
      ),
    );
  }

  Widget _buildOrderStatusSection(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 25),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLanguage == 'zh' ? '订单状态' : 'Order Status',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.primaryColorValue),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusItem(
                Icons.pending_actions,
                currentLanguage == 'zh' ? '待处理' : 'Pending',
                '2',
                Colors.orange,
              ),
              _buildStatusItem(
                Icons.local_shipping,
                currentLanguage == 'zh' ? '配送中' : 'Delivering',
                '1',
                Colors.blue,
              ),
              _buildStatusItem(
                Icons.check_circle,
                currentLanguage == 'zh' ? '已完成' : 'Completed',
                '15',
                Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // FIXED: Use helper method instead of direct withOpacity
            color: _withOpacity(color, 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveOrdersSection(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 25),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentLanguage == 'zh' ? '进行中的订单' : 'Active Orders',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle view all active orders
                },
                child: Text(
                  currentLanguage == 'zh' ? '查看全部' : 'View All',
                  style: const TextStyle(
                    color: Color(AppConstants.primaryColorValue),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActiveOrderItem(
            'ORD-001234',
            'Kung Pao Chicken + Rice',
            '¥68.00',
            currentLanguage == 'zh' ? '预计 30 分钟内送达' : 'Est. 30 min delivery',
            Icons.local_shipping,
            Colors.blue,
            currentLanguage,
          ),
          const SizedBox(height: 12),
          _buildActiveOrderItem(
            'ORD-001235',
            'Hot Pot Set for 2',
            '¥158.00',
            currentLanguage == 'zh' ? '餐厅准备中' : 'Restaurant preparing',
            Icons.restaurant,
            Colors.orange,
            currentLanguage,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrderItem(
    String orderId,
    String items,
    String price,
    String status,
    IconData icon,
    Color color,
    String currentLanguage,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(AppConstants.backgroundColorValue),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // FIXED: Use helper method instead of direct withOpacity
              color: _withOpacity(color, 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  items,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  _showOrderDetails(context, orderId, currentLanguage);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                ),
                child: Text(
                  currentLanguage == 'zh' ? '查看详情' : 'View Details',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistorySection(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 25),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentLanguage == 'zh' ? '历史订单' : 'Order History',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle view all order history
                },
                child: Text(
                  currentLanguage == 'zh' ? '查看全部' : 'View All',
                  style: const TextStyle(
                    color: Color(AppConstants.primaryColorValue),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHistoryOrderItem(
            'ORD-001233',
            'Dim Sum Set',
            '¥98.00',
            currentLanguage == 'zh' ? '2024-01-15' : '2024-01-15',
            currentLanguage == 'zh' ? '已完成' : 'Completed',
            currentLanguage,
          ),
          const SizedBox(height: 12),
          _buildHistoryOrderItem(
            'ORD-001232',
            'Cantonese Roast Duck',
            '¥128.00',
            currentLanguage == 'zh' ? '2024-01-14' : '2024-01-14',
            currentLanguage == 'zh' ? '已完成' : 'Completed',
            currentLanguage,
          ),
          const SizedBox(height: 12),
          _buildHistoryOrderItem(
            'ORD-001231',
            'Wonton Noodle Soup',
            '¥45.00',
            currentLanguage == 'zh' ? '2024-01-13' : '2024-01-13',
            currentLanguage == 'zh' ? '已完成' : 'Completed',
            currentLanguage,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryOrderItem(
    String orderId,
    String items,
    String price,
    String date,
    String status,
    String currentLanguage,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(AppConstants.backgroundColorValue),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // FIXED: Use helper method instead of direct withOpacity
              color: _withOpacity(Colors.green, 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  items,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        // FIXED: Use helper method instead of direct withOpacity
                        color: _withOpacity(Colors.green, 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  _reorderItem(context, orderId, currentLanguage);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                ),
                child: Text(
                  currentLanguage == 'zh' ? '再次订购' : 'Reorder',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context, String orderId, String currentLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$orderId ${currentLanguage == 'zh' ? '详情' : 'Details'}'),
          content: Text(currentLanguage == 'zh' 
              ? '订单详情页面正在开发中' 
              : 'Order details page is under development'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(currentLanguage == 'zh' ? '关闭' : 'Close'),
            ),
          ],
        );
      },
    );
  }

  void _reorderItem(BuildContext context, String orderId, String currentLanguage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$orderId ${currentLanguage == 'zh' ? '已添加到购物车' : 'added to cart'}'),
        backgroundColor: const Color(AppConstants.primaryColorValue),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
