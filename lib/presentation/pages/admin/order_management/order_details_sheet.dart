import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/order_model.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final Order order;

  const OrderDetailsBottomSheet({super.key, required this.order});

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
                'Order #${order.orderId}',
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
                  // Customer Info
                  _buildInfoSection('Customer Information', [
                    _buildInfoRow('Name', order.customerName),
                    _buildInfoRow('Phone', order.customerPhone),
                    _buildInfoRow('Email', order.customerEmail),
                    _buildInfoRow('Address', order.deliveryAddress),
                  ]),
                  
                  // Order Items
                  _buildOrderItemsSection(),
                  
                  // Payment Info
                  _buildInfoSection('Payment Information', [
                    _buildInfoRow('Method', order.paymentMethod.toString().split('.').last),
                    _buildInfoRow('Status', order.paymentStatus.toString().split('.').last),
                    _buildInfoRow('Total', '\$${order.totalAmount.toStringAsFixed(2)}'),
                    _buildInfoRow('Delivery Fee', '\$${order.deliveryFee.toStringAsFixed(2)}'),
                    _buildInfoRow('Tax', '\$${order.taxAmount.toStringAsFixed(2)}'),
                  ]),
                  
                  // Special Instructions
                  if (order.specialInstructions != null)
                    _buildInfoSection('Special Instructions', [
                      Text(order.specialInstructions!),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Order Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...order.items.map((item) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.fastfood, color: Colors.grey),
          ),
          title: Text(item.foodName),
          subtitle: Text('Qty: ${item.quantity} • \$${item.unitPrice} each'),
          trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
        )).toList(),
      ],
    );
  }

  Widget _buildStatusActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Update Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  // Update order status
                  _updateOrderStatus(context, status);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _updateOrderStatus(BuildContext context, OrderStatus newStatus) {
    // In a real app, you would call a method in OrderProvider to update the status
    // For now, we'll just print and close the sheet
    print('Updating order ${order.orderId} to $newStatus');
    Navigator.pop(context);
    // You might want to show a confirmation dialog or snackbar
  }

  String _getStatusText(OrderStatus status) {
    return status.toString().split('.').last;
  }
}
