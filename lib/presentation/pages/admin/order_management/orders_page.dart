import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/order_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: const Color(0xFF27AE60),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All Orders'),
            Tab(text: 'Pending'),
            Tab(text: 'Preparing'),
            Tab(text: 'Ready'),
            Tab(text: 'Delivery'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          _buildSearchFilterSection(),
          
          // Orders List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(context, 'all'),
                _buildOrdersList(context, 'pending'),
                _buildOrdersList(context, 'preparing'),
                _buildOrdersList(context, 'ready'),
                _buildOrdersList(context, 'outForDelivery'),
                _buildOrdersList(context, 'delivered'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickStats,
        backgroundColor: const Color(0xFF27AE60),
        child: const Icon(Icons.analytics, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchFilterSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by order ID, customer name, or phone...',
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
                _buildFilterChip('Today', 'today'),
                const SizedBox(width: 8),
                _buildFilterChip('This Week', 'week'),
                const SizedBox(width: 8),
                _buildFilterChip('High Priority', 'high'),
                const SizedBox(width: 8),
                _buildFilterChip('Delivery', 'delivery'),
                const SizedBox(width: 8),
                _buildFilterChip('Pickup', 'pickup'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
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

  Widget _buildOrdersList(BuildContext context, String status) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.getFilteredOrders(
          status: status,
          searchQuery: _searchController.text,
          timeFilter: _filterStatus,
        );

        if (orders.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No orders found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
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
              return _buildOrderCard(order);
            },
          ),
        );
      },
    );
  }

  // REPLACED: More robust order card with better error handling
  Widget _buildOrderCard(Order order) {
    // Safe order ID handling
    final displayOrderId = _getDisplayOrderId(order.orderId);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: _buildOrderStatusIcon(order.status),
        title: Text(
          'Order #$displayOrderId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.customerName} • ${_formatPhone(order.customerPhone)}'),
            Text('${order.items.length} ${order.items.length == 1 ? 'item' : 'items'} • \$${order.totalAmount.toStringAsFixed(2)}'),
            Text(
              '${_formatDateTime(order.orderDate)} • ${_getStatusText(order.status)}',
              style: TextStyle(
                color: _getStatusColor(order.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showOrderDetails(order),
      ),
    );
  }

  // ADDED: Safe method to get display order ID
  String _getDisplayOrderId(String orderId) {
    try {
      if (orderId.isEmpty) return 'N/A';
      if (orderId.length <= 8) return orderId;
      return '${orderId.substring(0, 4)}...${orderId.substring(orderId.length - 4)}';
    } catch (e) {
      return 'N/A';
    }
  }

  // ADDED: Format phone number safely
  String _formatPhone(String phone) {
    if (phone.isEmpty) return 'N/A';
    if (phone.length <= 10) return phone;
    
    try {
      // Format as (XXX) XXX-XXXX for US numbers
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    } catch (e) {
      return phone;
    }
  }

  // ADDED: Better date formatting
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

  // ADDED: Time formatting
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
        // ignore: deprecated_member_use
        color: Color.fromRGBO((color.red * 255).round(), (color.green * 255).round(), (color.blue * 255).round(), 0.1),
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

  String _getStatusText(OrderStatus status) {
    return status.toString().split('.').last;
  }

  // REMOVED: Old _formatDate method since we're using _formatDateTime now

  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => OrderDetailsBottomSheet(order: order),
    );
  }

  void _showQuickStats() {
    // For now, we'll just show a placeholder dialog.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Statistics'),
        content: const Text('Order statistics will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
