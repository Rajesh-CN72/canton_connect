import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/subscription_plan.dart';

class SubscriptionManagementPage extends StatefulWidget {
  final String currentLanguage;

  const SubscriptionManagementPage({
    super.key,
    required this.currentLanguage,
  });

  @override
  State<SubscriptionManagementPage> createState() => _SubscriptionManagementPageState();
}

class _SubscriptionManagementPageState extends State<SubscriptionManagementPage> {
  final List<SubscriptionPlan> _plans = [
    const SubscriptionPlan(
      id: 'basic',
      name: 'Basic Plan',
      description: 'Perfect for individuals',
      price: 99.99,
      period: '/week',
      features: [
        '5 meals per week',
        'Free delivery',
        'Basic support'
      ],
      isPopular: false,
      category: 'basic',
      icon: Icons.restaurant_menu,
      color: Colors.blue,
      maxMenuItems: 5,
    ),
    const SubscriptionPlan(
      id: 'standard',
      name: 'Standard Plan',
      description: 'Great for couples',
      price: 149.99,
      period: '/week',
      features: [
        '10 meals per week',
        'Free delivery',
        'Priority support',
        'Customizable meals'
      ],
      isPopular: true,
      category: 'standard',
      icon: Icons.star,
      color: Colors.green,
      maxMenuItems: 10,
    ),
    const SubscriptionPlan(
      id: 'premium',
      name: 'Premium Plan',
      description: 'Ideal for families',
      price: 199.99,
      period: '/week',
      features: [
        '20 meals per week',
        'Free delivery',
        '24/7 support',
        'Customizable meals',
        'Weekly nutrition report'
      ],
      isPopular: false,
      category: 'premium',
      icon: Icons.diamond,
      color: Colors.purple,
      maxMenuItems: 20,
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _periodController = TextEditingController();
  final _categoryController = TextEditingController();
  final _featuresController = TextEditingController();
  final _maxMenuItemsController = TextEditingController();
  bool _isPopular = false;
  String _editingPlanId = '';

  // Icon and Color selection
  IconData _selectedIcon = Icons.restaurant_menu;
  Color _selectedColor = Colors.blue;

  // Available icons and colors for selection
  final List<IconData> _availableIcons = const [
    Icons.restaurant_menu,
    Icons.star,
    Icons.diamond,
    Icons.work,
    Icons.family_restroom,
    Icons.favorite,
    Icons.spa,
    Icons.business_center,
    Icons.weekend,
    Icons.monitor_heart,
  ];

  final List<Color> _availableColors = const [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _periodController.dispose();
    _categoryController.dispose();
    _featuresController.dispose();
    _maxMenuItemsController.dispose();
    super.dispose();
  }

  void _editPlan(SubscriptionPlan plan) {
    setState(() {
      _editingPlanId = plan.id;
      _nameController.text = plan.name;
      _descriptionController.text = plan.description;
      _priceController.text = plan.price.toString();
      _periodController.text = plan.period;
      _categoryController.text = plan.category;
      _featuresController.text = plan.features.join('\n');
      _maxMenuItemsController.text = plan.maxMenuItems.toString();
      _isPopular = plan.isPopular;
      _selectedIcon = plan.icon;
      _selectedColor = plan.color;
    });
  }

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      final features = _featuresController.text.split('\n').where((f) => f.trim().isNotEmpty).toList();
      
      final updatedPlan = SubscriptionPlan(
        id: _editingPlanId,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        period: _periodController.text,
        features: features,
        isPopular: _isPopular,
        category: _categoryController.text,
        icon: _selectedIcon,
        color: _selectedColor,
        maxMenuItems: int.parse(_maxMenuItemsController.text),
      );

      setState(() {
        final index = _plans.indexWhere((plan) => plan.id == _editingPlanId);
        if (index != -1) {
          _plans[index] = updatedPlan;
        }
        _resetForm();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.currentLanguage == 'zh' ? '套餐更新成功' : 'Plan updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _resetForm() {
    _editingPlanId = '';
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _periodController.clear();
    _categoryController.clear();
    _featuresController.clear();
    _maxMenuItemsController.clear();
    _isPopular = false;
    _selectedIcon = Icons.restaurant_menu;
    _selectedColor = Colors.blue;
  }

  void _cancelEdit() {
    setState(_resetForm);
  }

  void _togglePopularStatus(String planId) {
    setState(() {
      final index = _plans.indexWhere((p) => p.id == planId);
      if (index != -1) {
        final plan = _plans[index];
        final updatedPlan = SubscriptionPlan(
          id: plan.id,
          name: plan.name,
          description: plan.description,
          price: plan.price,
          period: plan.period,
          features: plan.features,
          isPopular: !plan.isPopular,
          category: plan.category,
          icon: plan.icon,
          color: plan.color,
          maxMenuItems: plan.maxMenuItems,
        );
        _plans[index] = updatedPlan;
      }
    });
  }

  void _addNewPlan() {
    setState(() {
      _resetForm();
      _editingPlanId = 'new_${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  void _deletePlan(String planId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.currentLanguage == 'zh' ? '确认删除' : 'Confirm Delete'),
        content: Text(widget.currentLanguage == 'zh' 
            ? '您确定要删除这个套餐吗？此操作无法撤销。'
            : 'Are you sure you want to delete this plan? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(widget.currentLanguage == 'zh' ? '取消' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _plans.removeWhere((plan) => plan.id == planId);
                if (_editingPlanId == planId) {
                  _resetForm();
                }
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(widget.currentLanguage == 'zh' ? '套餐删除成功' : 'Plan deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(widget.currentLanguage == 'zh' ? '删除' : 'Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentLanguage == 'zh' ? '套餐管理' : 'Subscription Management'),
        backgroundColor: const Color(0xFF2E8B57),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewPlan,
            tooltip: widget.currentLanguage == 'zh' ? '添加新套餐' : 'Add New Plan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Edit Form
            if (_editingPlanId.isNotEmpty) ...[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _editingPlanId.startsWith('new') 
                              ? (widget.currentLanguage == 'zh' ? '添加新套餐' : 'Add New Plan')
                              : (widget.currentLanguage == 'zh' ? '编辑套餐' : 'Edit Plan'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Icon and Color Selection
                        Row(
                          children: [
                            // Icon Selection
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.currentLanguage == 'zh' ? '选择图标' : 'Select Icon'),
                                  const SizedBox(height: 8),
                                  DropdownButton<IconData>(
                                    value: _selectedIcon,
                                    onChanged: (IconData? newValue) {
                                      setState(() {
                                        _selectedIcon = newValue!;
                                      });
                                    },
                                    items: _availableIcons.map((IconData icon) {
                                      return DropdownMenuItem<IconData>(
                                        value: icon,
                                        child: Row(
                                          children: [
                                            Icon(icon),
                                            const SizedBox(width: 8),
                                            Text(icon.toString().split('.')[1]),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Color Selection
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.currentLanguage == 'zh' ? '选择颜色' : 'Select Color'),
                                  const SizedBox(height: 8),
                                  DropdownButton<Color>(
                                    value: _selectedColor,
                                    onChanged: (Color? newValue) {
                                      setState(() {
                                        _selectedColor = newValue!;
                                      });
                                    },
                                    items: _availableColors.map((Color color) {
                                      return DropdownMenuItem<Color>(
                                        value: color,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              color: color,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(color.toString().split('(0x')[1].split(')')[0]),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Plan Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return widget.currentLanguage == 'zh' ? '请输入套餐名称' : 'Please enter plan name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Plan Description',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return widget.currentLanguage == 'zh' ? '请输入套餐描述' : 'Please enter plan description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _priceController,
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return widget.currentLanguage == 'zh' ? '请输入价格' : 'Please enter price';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return widget.currentLanguage == 'zh' ? '请输入有效的价格' : 'Please enter a valid price';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _periodController,
                                decoration: const InputDecoration(
                                  labelText: 'Period',
                                  border: OutlineInputBorder(),
                                  hintText: '/week or /月',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return widget.currentLanguage == 'zh' ? '请输入周期' : 'Please enter period';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return widget.currentLanguage == 'zh' ? '请输入分类' : 'Please enter category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _maxMenuItemsController,
                          decoration: const InputDecoration(
                            labelText: 'Max Menu Items',
                            border: OutlineInputBorder(),
                            hintText: 'Enter maximum menu items allowed',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return widget.currentLanguage == 'zh' ? '请输入最大菜单项数量' : 'Please enter max menu items';
                            }
                            if (int.tryParse(value) == null) {
                              return widget.currentLanguage == 'zh' ? '请输入有效的数字' : 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _featuresController,
                          decoration: const InputDecoration(
                            labelText: 'Features (one per line)',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return widget.currentLanguage == 'zh' ? '请输入至少一个功能' : 'Please enter at least one feature';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _isPopular,
                              onChanged: (value) {
                                setState(() {
                                  _isPopular = value ?? false;
                                });
                              },
                            ),
                            Text(widget.currentLanguage == 'zh' ? '标记为热门' : 'Mark as Popular'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _savePlan,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E8B57),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(_editingPlanId.startsWith('new')
                                    ? (widget.currentLanguage == 'zh' ? '添加套餐' : 'Add Plan')
                                    : (widget.currentLanguage == 'zh' ? '保存' : 'Save')),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _cancelEdit,
                                child: Text(widget.currentLanguage == 'zh' ? '取消' : 'Cancel'),
                              ),
                            ),
                            if (!_editingPlanId.startsWith('new')) ...[
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _deletePlan(_editingPlanId),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text(widget.currentLanguage == 'zh' ? '删除' : 'Delete'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Plans List Header
            Row(
              children: [
                Text(
                  widget.currentLanguage == 'zh' ? '套餐列表' : 'Subscription Plans',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${_plans.length} ${widget.currentLanguage == 'zh' ? '个套餐' : 'plans'}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Plans List
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  final plan = _plans[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Icon and Name
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: plan.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(plan.icon, color: plan.color, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      plan.description,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (plan.isPopular)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    widget.currentLanguage == 'zh' ? '热门' : 'Popular',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Price and Category
                          Row(
                            children: [
                              Text(
                                '\$${plan.price.toStringAsFixed(2)}${plan.period}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E8B57),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  plan.category,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${plan.maxMenuItems} items',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Features
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: plan.features.map((feature) => Chip(
                              label: Text(
                                feature,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: plan.color.withOpacity(0.1),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                            )).toList(),
                          ),
                          const SizedBox(height: 16),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _editPlan(plan),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E8B57),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(widget.currentLanguage == 'zh' ? '编辑' : 'Edit'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => _togglePopularStatus(plan.id),
                                  child: Text(
                                    plan.isPopular 
                                      ? (widget.currentLanguage == 'zh' ? '取消热门' : 'Unmark Popular')
                                      : (widget.currentLanguage == 'zh' ? '设为热门' : 'Mark Popular'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
