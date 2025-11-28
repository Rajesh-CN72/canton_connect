import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';

class HealthConceptsPage extends StatefulWidget {
  const HealthConceptsPage({super.key});

  @override
  State<HealthConceptsPage> createState() => _HealthConceptsPageState();
}

class _HealthConceptsPageState extends State<HealthConceptsPage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentLanguage == 'en' ? 'Health Concepts' : '健康理念',
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.health_and_safety,
                      size: 64,
                      color: Color(0xFF27AE60),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentLanguage == 'en'
                          ? 'Traditional Chinese Medicine Meets Modern Nutrition'
                          : '传统中医与现代营养学的完美结合',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentLanguage == 'en'
                          ? 'Balancing your body through carefully crafted meals based on ancient wisdom and scientific research'
                          : '基于古老智慧和科学研究，通过精心制作的餐食平衡您的身体',
                      style: const TextStyle(
                        color: Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Health principles
            Text(
              currentLanguage == 'en' ? 'Our Principles' : '我们的原则',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 16),

            _buildPrincipleCard(
              currentLanguage == 'en' 
                  ? 'Seasonal Eating'
                  : '应季饮食',
              currentLanguage == 'en'
                  ? 'Our meals are designed according to seasonal changes to maintain balance with nature'
                  : '我们的餐食根据季节变化设计，以保持与自然的平衡',
              Icons.nature,
            ),
            _buildPrincipleCard(
              currentLanguage == 'en' 
                  ? 'Yin-Yang Balance'
                  : '阴阳平衡',
              currentLanguage == 'en'
                  ? 'Balancing cooling and warming foods to maintain optimal health'
                  : '平衡凉性和温性食物，维持最佳健康状态',
              Icons.balance,
            ),
            _buildPrincipleCard(
              currentLanguage == 'en' 
                  ? 'Five Elements'
                  : '五行理论',
              currentLanguage == 'en'
                  ? 'Incorporating the five elements theory to create harmonious meals'
                  : '融入五行理论，创造和谐的餐食',
              Icons.auto_awesome,
            ),
            _buildPrincipleCard(
              currentLanguage == 'en' 
                  ? 'Qi & Blood'
                  : '气血调理',
              currentLanguage == 'en'
                  ? 'Focusing on foods that promote healthy Qi and blood circulation'
                  : '专注于促进健康气血循环的食物',
              Icons.favorite,
            ),

            const SizedBox(height: 20),

            // Benefits section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLanguage == 'en' ? 'Health Benefits' : '健康益处',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBenefitItem(
                      currentLanguage == 'en' 
                          ? 'Improved digestion and gut health'
                          : '改善消化和肠道健康',
                    ),
                    _buildBenefitItem(
                      currentLanguage == 'en' 
                          ? 'Enhanced energy levels'
                          : '提高能量水平',
                    ),
                    _buildBenefitItem(
                      currentLanguage == 'en' 
                          ? 'Better sleep quality'
                          : '改善睡眠质量',
                    ),
                    _buildBenefitItem(
                      currentLanguage == 'en' 
                          ? 'Strengthened immune system'
                          : '增强免疫系统',
                    ),
                    _buildBenefitItem(
                      currentLanguage == 'en' 
                          ? 'Reduced inflammation'
                          : '减少炎症',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Consultation CTA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.medical_services,
                    size: 48,
                    color: Color(0xFF27AE60),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentLanguage == 'en'
                        ? 'Personalized Health Consultation'
                        : '个性化健康咨询',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentLanguage == 'en'
                        ? 'Get personalized dietary recommendations based on your body constitution'
                        : '根据您的体质获得个性化的饮食建议',
                    style: const TextStyle(
                      color: Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _scheduleConsultation(context, currentLanguage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27AE60),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      currentLanguage == 'en' 
                          ? 'Book Consultation' 
                          : '预约咨询',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPrincipleCard(
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: const Color(0xFF27AE60)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF27AE60),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleConsultation(BuildContext context, String currentLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            currentLanguage == 'en' 
                ? 'Schedule Consultation' 
                : '预约咨询',
            style: const TextStyle(
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            currentLanguage == 'en'
                ? 'Our health consultant will contact you within 24 hours to schedule your personalized consultation.'
                : '我们的健康顾问将在24小时内联系您，安排个性化的咨询。',
            style: const TextStyle(
              color: Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                currentLanguage == 'en' ? 'Cancel' : '取消',
                style: const TextStyle(color: Color(0xFF666666)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmation(context, currentLanguage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27AE60),
              ),
              child: Text(
                currentLanguage == 'en' ? 'Confirm' : '确认',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmation(BuildContext context, String currentLanguage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          currentLanguage == 'en'
              ? 'Consultation request submitted successfully!'
              : '咨询请求已成功提交！',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF27AE60),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

