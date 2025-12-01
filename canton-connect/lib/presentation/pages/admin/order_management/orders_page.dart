import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/order_provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';
import 'package:canton_connect/data/models/order_model.dart';
import 'order_details_sheet.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.currentLanguage == 'zh';

    return Scaffold(
      appBar: AdminAppBar(
        title: isChinese ? '订单管理' : 'Order Management',
        showBackButton: true,
        currentLanguage: languageProvider.currentLanguage,
        onLanguageChanged: (newLanguage) {
          languageProvider.setLanguageByCode(newLanguage);
        },
      ),
      body: Column(
        children: [
          // Search and Filter Section
          _buildSearchFilterSection(isChinese),
          
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF27AE60),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF27AE60),
              tabs: [
                Tab(text: isChinese ? '全部订单' : 'All Orders'),
                Tab(text: isChinese ? '待处理' : 'Pending'),
                Tab(text: isChinese ? '准备中' : 'Preparing'),
                Tab(text: isChinese ? '已就绪' : 'Ready'),
                Tab(text: isChinese ? '配送中' : 'Delivery'),
                Tab(text: isChinese ? '已完成' : 'Completed'),
              ],
            ),
          ),
          
          // Orders List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(context, 'all', isChinese),
                _buildOrdersList(context, 'pending', isChinese),
                _buildOrdersList(context, 'preparing', isChinese),
                _buildOrdersList(context, 'ready', isChinese),
                _buildOrdersList(context, 'outForDelivery', isChinese),
                _buildOrdersList(context, 'delivered', isChinese),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickStats(isChinese, context),
        backgroundColor: const Color(0xFF27AE60),
        child: const Icon(Icons.analytics, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchFilterSection(bool isChinese) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: isChinese 
                ? '搜索订单ID、客户姓名或电话...'
                : 'Search by order ID, customer name, or phone...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 12),
          
          // Quick Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(isChinese ? '今天' : 'Today', 'today', isChinese),
                const SizedBox(width: 8),
                _buildFilterChip(isChinese ? '本周' : 'This Week', 'week', isChinese),
                const SizedBox(width: 8),
                _buildFilterChip(isChinese ? '高优先级' : 'High Priority', 'high', isChinese),
                const SizedBox(width: 8),
                _buildFilterChip(isChinese ? '外卖' : 'Delivery', 'delivery', isChinese),
                const SizedBox(width: 8),
                _buildFilterChip(isChinese ? '自取' : 'Pickup', 'pickup', isChinese),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, bool isChinese) {
    return FilterChip(
      label: Text(label),
      selected: _filterStatus == value,
      onSelected: (selected) {
        setState(() {
          _filterStatus = selected ? value : 'all';
        });
      },
    );
  }

  Widget _buildOrdersList(BuildContext context, String status, bool isChinese) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.getFilteredOrders(
          status: status,
          searchQuery: _searchController.text,
          timeFilter: _filterStatus,
        );

        if (orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  isChinese ? '暂无订单' : 'No orders found',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => orderProvider.refreshOrders(),
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order, isChinese);
            },
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(Order order, bool isChinese) {
    final displayOrderId = _getDisplayOrderId(order.orderId);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: _buildOrderStatusIcon(order.status),
        title: Text(
          isChinese ? '订单 #$displayOrderId' : 'Order #$displayOrderId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.customerName} • ${_formatPhone(order.customerPhone)}'),
            Text(
              isChinese 
                ? '${order.items.length} 件商品 • \$${order.totalAmount.toStringAsFixed(2)}'
                : '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'} • \$${order.totalAmount.toStringAsFixed(2)}'
            ),
            Text(
              '${_formatDateTime(order.orderDate)} • ${_getStatusText(order.status, isChinese)}',
              style: TextStyle(
                color: _getStatusColor(order.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showOrderDetails(order, isChinese, context),
      ),
    );
  }

  String _getDisplayOrderId(String orderId) {
    try {
      if (orderId.isEmpty) return 'N/A';
      if (orderId.length <= 8) return orderId;
      return '${orderId.substring(0, 4)}...${orderId.substring(orderId.length - 4)}';
    } catch (e) {
      return 'N/A';
    }
  }

  String _formatPhone(String phone) {
    if (phone.isEmpty) return 'N/A';
    if (phone.length <= 10) return phone;
    
    try {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    } catch (e) {
      return phone;
    }
  }

  String _formatDateTime(DateTime date) {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final orderDay = DateTime(date.year, date.month, date.day);
      
      if (orderDay == today) {
        return 'Today ${_formatTime(date)}';
      } else if (orderDay == today.subtract(const Duration(days: 1))) {
        return 'Yesterday ${_formatTime(date)}';
      } else {
        return '${date.month}/${date.day} ${_formatTime(date)}';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  String _formatTime(DateTime date) {
    try {
      final hour = date.hour;
      final minute = date.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;
      
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return 'Unknown';
    }
  }

  Widget _buildOrderStatusIcon(OrderStatus status) {
    final color = _getStatusColor(status);
    final icon = _getStatusIcon(status);
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.ready:
        return Colors.green;
      case OrderStatus.outForDelivery:
        return Colors.teal;
      case OrderStatus.delivered:
        return const Color(0xFF27AE60);
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.refunded:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.access_time;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.preparing:
        return Icons.restaurant;
      case OrderStatus.ready:
        return Icons.emoji_food_beverage;
      case OrderStatus.outForDelivery:
        return Icons.delivery_dining;
      case OrderStatus.delivered:
        return Icons.verified;
      case OrderStatus.cancelled:
        return Icons.cancel;
      case OrderStatus.refunded:
        return Icons.money_off;
    }
  }

  String _getStatusText(OrderStatus status, bool isChinese) {
    switch (status) {
      case OrderStatus.pending:
        return isChinese ? '待处理' : 'Pending';
      case OrderStatus.confirmed:
        return isChinese ? '已确认' : 'Confirmed';
      case OrderStatus.preparing:
        return isChinese ? '准备中' : 'Preparing';
      case OrderStatus.ready:
        return isChinese ? '已就绪' : 'Ready';
      case OrderStatus.outForDelivery:
        return isChinese ? '配送中' : 'Out for Delivery';
      case OrderStatus.delivered:
        return isChinese ? '已完成' : 'Delivered';
      case OrderStatus.cancelled:
        return isChinese ? '已取消' : 'Cancelled';
      case OrderStatus.refunded:
        return isChinese ? '已退款' : 'Refunded';
      default:
        return status.toString().split('.').last;
    }
  }

  void _showOrderDetails(Order order, bool isChinese, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => OrderDetailsBottomSheet(order: order, isChinese: isChinese),
    );
  }

  void _showQuickStats(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '订单统计' : 'Order Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatItem(isChinese ? '今日订单' : "Today's Orders", '12', Colors.blue),
            _buildStatItem(isChinese ? '待处理' : 'Pending', '3', Colors.orange),
            _buildStatItem(isChinese ? '总收入' : 'Total Revenue', '\$1,245', Colors.green),
            _buildStatItem(isChinese ? '平均订单价值' : 'Avg Order Value', '\$103.75', Colors.purple),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '关闭' : 'Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
