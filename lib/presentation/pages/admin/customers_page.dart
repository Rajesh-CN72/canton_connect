import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'all'; // all, active, new, vip
  String _sortBy = 'recent'; // recent, name, orders, spending

  // Mock customer data
  final List<Customer> _customers = [
    Customer(
      id: '1',
      name: '张三',
      nameEn: 'Zhang San',
      email: 'zhangsan@email.com',
      phone: '13800138001',
      joinDate: DateTime(2024, 1, 10),
      totalOrders: 15,
      totalSpent: 2450.00,
      status: 'active',
      lastOrder: DateTime(2024, 1, 15),
      address: '北京市朝阳区xxx街道123号',
      addressEn: '123 XXX Street, Chaoyang District, Beijing',
      notes: '偏好辣味，经常点宫保鸡丁',
      notesEn: 'Prefers spicy food, often orders Kung Pao Chicken',
    ),
    Customer(
      id: '2',
      name: '李四',
      nameEn: 'Li Si',
      email: 'lisi@email.com',
      phone: '13900139002',
      joinDate: DateTime(2024, 1, 5),
      totalOrders: 8,
      totalSpent: 1200.50,
      status: 'active',
      lastOrder: DateTime(2024, 1, 14),
      address: '北京市海淀区yyy街道456号',
      addressEn: '456 YYY Street, Haidian District, Beijing',
      notes: '新客户，喜欢尝试新菜品',
      notesEn: 'New customer, likes to try new dishes',
    ),
    Customer(
      id: '3',
      name: '王五',
      nameEn: 'Wang Wu',
      email: 'wangwu@email.com',
      phone: '13700137003',
      joinDate: DateTime(2023, 12, 20),
      totalOrders: 25,
      totalSpent: 3890.00,
      status: 'vip',
      lastOrder: DateTime(2024, 1, 15),
      address: '北京市东城区zzz街道789号',
      addressEn: '789 ZZZ Street, Dongcheng District, Beijing',
      notes: 'VIP客户，经常商务宴请',
      notesEn: 'VIP customer, often business dining',
    ),
    Customer(
      id: '4',
      name: '赵六',
      nameEn: 'Zhao Liu',
      email: 'zhaoliu@email.com',
      phone: '13600136004',
      joinDate: DateTime(2024, 1, 12),
      totalOrders: 2,
      totalSpent: 180.00,
      status: 'new',
      lastOrder: DateTime(2024, 1, 13),
      address: '北京市西城区aaa街道101号',
      addressEn: '101 AAA Street, Xicheng District, Beijing',
      notes: '第一次订购，对服务满意',
      notesEn: 'First time ordering, satisfied with service',
    ),
    Customer(
      id: '5',
      name: '钱七',
      nameEn: 'Qian Qi',
      email: 'qianqi@email.com',
      phone: '13500135005',
      joinDate: DateTime(2023, 11, 15),
      totalOrders: 12,
      totalSpent: 1560.00,
      status: 'inactive',
      lastOrder: DateTime(2023, 12, 28),
      address: '北京市丰台区bbb街道202号',
      addressEn: '202 BBB Street, Fengtai District, Beijing',
      notes: '一个月未下单',
      notesEn: 'No orders in the last month',
    ),
  ];

  List<Customer> get _filteredCustomers {
    var filtered = _customers;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((customer) =>
          customer.name.toLowerCase().contains(query) ||
          customer.nameEn.toLowerCase().contains(query) ||
          customer.email.toLowerCase().contains(query) ||
          customer.phone.contains(query)).toList();
    }

    // Apply status filter
    if (_filterStatus != 'all') {
      filtered = filtered.where((customer) => customer.status == _filterStatus).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'orders':
        filtered.sort((a, b) => b.totalOrders.compareTo(a.totalOrders));
        break;
      case 'spending':
        filtered.sort((a, b) => b.totalSpent.compareTo(a.totalSpent));
        break;
      case 'recent':
      default:
        filtered.sort((a, b) => b.lastOrder.compareTo(a.lastOrder));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.currentLanguage == 'zh';

    return Scaffold(
      appBar: AdminAppBar(
        title: isChinese ? '客户管理' : 'Customer Management',
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
          
          // Customer Statistics
          _buildCustomerStats(isChinese),
          
          // Customers List
          Expanded(
            child: _filteredCustomers.isEmpty
                ? _buildEmptyState(isChinese)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = _filteredCustomers[index];
                      return _buildCustomerCard(customer, isChinese, context);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewCustomer(isChinese, context),
        backgroundColor: const Color(0xFF1a237e),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchFilterSection(bool isChinese) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: isChinese 
                ? '搜索客户姓名、邮箱或电话...'
                : 'Search by name, email, or phone...',
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
          
          // Filters Row
          Row(
            children: [
              // Status Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _filterStatus,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text(isChinese ? '全部客户' : 'All Customers'),
                        ),
                        DropdownMenuItem(
                          value: 'active',
                          child: Text(isChinese ? '活跃客户' : 'Active'),
                        ),
                        DropdownMenuItem(
                          value: 'new',
                          child: Text(isChinese ? '新客户' : 'New'),
                        ),
                        DropdownMenuItem(
                          value: 'vip',
                          child: Text(isChinese ? 'VIP客户' : 'VIP'),
                        ),
                        DropdownMenuItem(
                          value: 'inactive',
                          child: Text(isChinese ? '不活跃' : 'Inactive'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _filterStatus = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Sort Button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'recent',
                      child: Text(isChinese ? '最近活跃' : 'Recent Activity'),
                    ),
                    PopupMenuItem(
                      value: 'name',
                      child: Text(isChinese ? '按姓名' : 'By Name'),
                    ),
                    PopupMenuItem(
                      value: 'orders',
                      child: Text(isChinese ? '按订单数' : 'By Orders'),
                    ),
                    PopupMenuItem(
                      value: 'spending',
                      child: Text(isChinese ? '按消费额' : 'By Spending'),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.sort, size: 20),
                        const SizedBox(width: 4),
                        Text(isChinese ? '排序' : 'Sort'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerStats(bool isChinese) {
    final totalCustomers = _customers.length;
    final activeCustomers = _customers.where((c) => c.status == 'active').length;
    final newCustomers = _customers.where((c) => c.status == 'new').length;
    final vipCustomers = _customers.where((c) => c.status == 'vip').length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            isChinese ? '总客户' : 'Total',
            totalCustomers.toString(),
            Colors.blue,
          ),
          _buildStatItem(
            isChinese ? '活跃' : 'Active',
            activeCustomers.toString(),
            Colors.green,
          ),
          _buildStatItem(
            isChinese ? '新客户' : 'New',
            newCustomers.toString(),
            Colors.orange,
          ),
          _buildStatItem(
            isChinese ? 'VIP' : 'VIP',
            vipCustomers.toString(),
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerCard(Customer customer, bool isChinese, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildCustomerAvatar(customer),
        title: Text(
          isChinese ? customer.name : customer.nameEn,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(customer.email),
            const SizedBox(height: 2),
            Text(customer.phone),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatusBadge(customer.status, isChinese),
                const SizedBox(width: 8),
                Text(
                  '${customer.totalOrders} ${isChinese ? '个订单' : 'orders'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '¥${customer.totalSpent.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              _formatDate(customer.lastOrder, isChinese),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        onTap: () => _showCustomerDetails(customer, isChinese, context),
      ),
    );
  }

  Widget _buildCustomerAvatar(Customer customer) {
    final color = _getStatusColor(customer.status);
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Center(
        child: Text(
          customer.name.substring(0, 1),
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, bool isChinese) {
    final color = _getStatusColor(status);
    final text = _getStatusText(status, isChinese);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'new':
        return Colors.orange;
      case 'vip':
        return Colors.purple;
      case 'inactive':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _getStatusText(String status, bool isChinese) {
    switch (status) {
      case 'active':
        return isChinese ? '活跃' : 'Active';
      case 'new':
        return isChinese ? '新客户' : 'New';
      case 'vip':
        return isChinese ? 'VIP' : 'VIP';
      case 'inactive':
        return isChinese ? '不活跃' : 'Inactive';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date, bool isChinese) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return isChinese ? '今天' : 'Today';
    } else if (difference.inDays == 1) {
      return isChinese ? '昨天' : 'Yesterday';
    } else if (difference.inDays < 7) {
      return isChinese ? '${difference.inDays}天前' : '${difference.inDays}d ago';
    } else {
      return '${date.month}/${date.day}';
    }
  }

  Widget _buildEmptyState(bool isChinese) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            isChinese ? '暂无客户' : 'No customers found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isChinese ? '尝试调整搜索条件' : 'Try adjusting your search criteria',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomerDetails(Customer customer, bool isChinese, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCustomerDetailsSheet(customer, isChinese, context),
    );
  }

  Widget _buildCustomerDetailsSheet(Customer customer, bool isChinese, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isChinese ? '客户详情' : 'Customer Details',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Customer Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Avatar and Basic Info
                  Row(
                    children: [
                      _buildCustomerAvatar(customer),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isChinese ? customer.name : customer.nameEn,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildStatusBadge(customer.status, isChinese),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Contact Info
                  _buildInfoRow(Icons.email, isChinese ? '邮箱' : 'Email', customer.email),
                  _buildInfoRow(Icons.phone, isChinese ? '电话' : 'Phone', customer.phone),
                  if (customer.address != null)
                    _buildInfoRow(
                      Icons.location_on, 
                      isChinese ? '地址' : 'Address', 
                      isChinese ? customer.address! : customer.addressEn!,
                    ),
                  _buildInfoRow(
                    Icons.calendar_today, 
                    isChinese ? '加入日期' : 'Join Date', 
                    _formatFullDate(customer.joinDate, isChinese),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Statistics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailStat(
                    isChinese ? '总订单' : 'Total Orders',
                    customer.totalOrders.toString(),
                    Icons.shopping_cart,
                  ),
                  _buildDetailStat(
                    isChinese ? '总消费' : 'Total Spent',
                    '¥${customer.totalSpent.toStringAsFixed(2)}',
                    Icons.attach_money,
                  ),
                  _buildDetailStat(
                    isChinese ? '平均订单' : 'Avg Order',
                    '¥${(customer.totalSpent / customer.totalOrders).toStringAsFixed(2)}',
                    Icons.trending_up,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Notes
          if (customer.notes != null && customer.notes!.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isChinese ? '备注' : 'Notes',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isChinese ? customer.notes! : customer.notesEn!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _contactCustomer(customer.phone),
                  child: Text(isChinese ? '联系客户' : 'Contact Customer'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _viewOrderHistory(customer, isChinese, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1a237e),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isChinese ? '订单历史' : 'Order History'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  String _formatFullDate(DateTime date, bool isChinese) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year;
    
    return isChinese 
        ? '$year年$month月$day日'
        : '$month/$day/$year';
  }

  void _addNewCustomer(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '添加新客户' : 'Add New Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '姓名' : 'Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '邮箱' : 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '电话' : 'Phone',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '取消' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(isChinese ? '客户添加成功' : 'Customer added successfully', context);
            },
            child: Text(isChinese ? '添加' : 'Add'),
          ),
        ],
      ),
    );
  }

  void _contactCustomer(String phone) {
    // Implement phone call functionality
    // You can use url_launcher package for this
    debugPrint('Contacting customer at: $phone');
  }

  void _viewOrderHistory(Customer customer, bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '${customer.name}的订单历史' : '${customer.nameEn}\'s Order History'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              // Mock order history items
              _buildOrderHistoryItem('ORD-001', '¥245.00', '2024-01-15', isChinese),
              _buildOrderHistoryItem('ORD-002', '¥189.50', '2024-01-10', isChinese),
              _buildOrderHistoryItem('ORD-003', '¥320.00', '2024-01-05', isChinese),
            ],
          ),
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

  Widget _buildOrderHistoryItem(String orderId, String amount, String date, bool isChinese) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.receipt, color: Colors.blue),
        title: Text(orderId),
        subtitle: Text(isChinese ? '日期: $date' : 'Date: $date'),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Customer Model
class Customer {
  final String id;
  final String name;
  final String nameEn;
  final String email;
  final String phone;
  final DateTime joinDate;
  final int totalOrders;
  final double totalSpent;
  final String status;
  final DateTime lastOrder;
  final String? address;
  final String? addressEn;
  final String? notes;
  final String? notesEn;

  Customer({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.totalOrders,
    required this.totalSpent,
    required this.status,
    required this.lastOrder,
    this.address,
    this.addressEn,
    this.notes,
    this.notesEn,
  });
}
