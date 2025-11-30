import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/order_model.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final Order order;
  final bool isChinese;

  const OrderDetailsBottomSheet({
    super.key, 
    required this.order,
    required this.isChinese,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isChinese ? '订单详情 #${order.orderId}' : 'Order #${order.orderId}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Status with better visual
                  _buildOrderStatusSection(context),
                  
                  // Customer Info
                  _buildInfoSection(isChinese ? '客户信息' : 'Customer Information', [
                    _buildInfoRow(isChinese ? '姓名' : 'Name', order.customerName),
                    _buildInfoRow(isChinese ? '电话' : 'Phone', order.customerPhone),
                    if (order.customerEmail.isNotEmpty) // FIXED: Safe null check
                      _buildInfoRow(isChinese ? '邮箱' : 'Email', order.customerEmail),
                    if (order.deliveryAddress.isNotEmpty) // FIXED: Safe null check
                      _buildInfoRow(isChinese ? '地址' : 'Address', order.deliveryAddress),
                  ]),
                  
                  // Order Items
                  _buildOrderItemsSection(),
                  
                  // Payment Info
                  _buildInfoSection(isChinese ? '支付信息' : 'Payment Information', [
                    _buildInfoRow(isChinese ? '支付方式' : 'Method', _getPaymentMethodText(order.paymentMethod)),
                    _buildInfoRow(isChinese ? '支付状态' : 'Payment Status', _getPaymentStatusText(order.paymentStatus)),
                    _buildInfoRow(isChinese ? '商品总额' : 'Subtotal', '\$${order.totalAmount.toStringAsFixed(2)}'),
                    _buildInfoRow(isChinese ? '配送费' : 'Delivery Fee', '\$${order.deliveryFee.toStringAsFixed(2)}'),
                    _buildInfoRow(isChinese ? '税费' : 'Tax', '\$${order.taxAmount.toStringAsFixed(2)}'),
                    _buildInfoRow(
                      isChinese ? '总计' : 'Total', 
                      '\$${(order.totalAmount + order.deliveryFee + order.taxAmount).toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ]),
                  
                  // Special Instructions
                  if (order.specialInstructions?.isNotEmpty ?? false) // FIXED: Safe null check
                    _buildInfoSection(isChinese ? '特殊要求' : 'Special Instructions', [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order.specialInstructions!, // FIXED: Safe to use ! after null check
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                  
                  // Status Actions
                  _buildStatusActions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _getStatusColor(order.status).withAlpha(26),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(order.status).withAlpha(77)),
      ),
      child: Row(
        children: [
          Icon(
            _getStatusIcon(order.status),
            color: _getStatusColor(order.status),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isChinese ? '订单状态' : 'Order Status',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  _getStatusText(order.status),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ],
            ),
          ),
          if (_canUpdateStatus(order.status))
            ElevatedButton(
              onPressed: () => _showStatusUpdateDialog(context),
              child: Text(isChinese ? '更新状态' : 'Update Status'),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          isChinese ? '订单商品' : 'Order Items',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...order.items.map((item) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.fastfood, color: Colors.grey),
            ),
            title: Text(item.foodName),
            subtitle: Text(
              isChinese 
                ? '数量: ${item.quantity} • 单价: \$${item.unitPrice}'
                : 'Qty: ${item.quantity} • \$${item.unitPrice} each'
            ),
            trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
          ),
        )),
      ],
    );
  }

  Widget _buildStatusActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          isChinese ? '更新状态' : 'Update Status',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: OrderStatus.values.map((status) {
            return FilterChip(
              label: Text(_getStatusText(status)),
              selected: order.status == status,
              onSelected: (selected) {
                if (selected) {
                  _updateOrderStatus(context, status);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showStatusUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '更新订单状态' : 'Update Order Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: OrderStatus.values.map((status) {
            return ListTile(
              leading: Icon(_getStatusIcon(status), color: _getStatusColor(status)),
              title: Text(_getStatusText(status)),
              trailing: order.status == status ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () {
                _updateOrderStatus(context, status);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _updateOrderStatus(BuildContext context, OrderStatus newStatus) {
    // In a real app, you would call a method in OrderProvider to update the status
    debugPrint('Updating order ${order.orderId} to $newStatus');
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isChinese 
            ? '订单状态已更新为: ${_getStatusText(newStatus)}'
            : 'Order status updated to: ${_getStatusText(newStatus)}'
        ),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context);
  }

  String _getStatusText(OrderStatus status) {
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
    }
  }

  String _getPaymentMethodText(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return isChinese ? '信用卡' : 'Credit Card';
      case PaymentMethod.debitCard:
        return isChinese ? '借记卡' : 'Debit Card';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.cash:
        return isChinese ? '现金' : 'Cash';
      case PaymentMethod.wechat:
        return isChinese ? '微信支付' : 'WeChat Pay';
      case PaymentMethod.alipay:
        return isChinese ? '支付宝' : 'Alipay';
    }
  }

  String _getPaymentStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return isChinese ? '待支付' : 'Pending';
      case PaymentStatus.completed:
        return isChinese ? '已支付' : 'Completed';
      case PaymentStatus.failed:
        return isChinese ? '支付失败' : 'Failed';
      case PaymentStatus.refunded:
        return isChinese ? '已退款' : 'Refunded';
    }
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

  bool _canUpdateStatus(OrderStatus status) {
    return status != OrderStatus.delivered && 
           status != OrderStatus.cancelled && 
           status != OrderStatus.refunded;
  }
}
