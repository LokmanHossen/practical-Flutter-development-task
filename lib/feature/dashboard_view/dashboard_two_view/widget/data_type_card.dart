import 'package:flutter/material.dart';
import 'package:scube_app/core/style/global_text_style.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/models/dashboard_two_model.dart';

class DataTypeCard extends StatelessWidget {
  final EnergyData data;

  const DataTypeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE5F4FE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFA5A7B9)),
      ),
      child: Row(
        children: [
          Container(
           
            decoration: BoxDecoration(
           
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(data.image,height: 28,width: 28,)
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: data.color,
                            borderRadius: BorderRadius.circular(3)
                          ),
                        ),
                          const SizedBox(width: 6),
                        
                        Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF04063E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Text(
                      data.isActive ? '(Active)' : '(Inactive)',
                      style:  TextStyle(
                        color:  data.isActive ? Color(0xFF0096FC) : Color(0xFFDF2222),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
               RichText(
                  text: TextSpan(
                    text: 'Data 1    : ',
                    style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFF646984),
                    ),
                    children: [
                      TextSpan(
                        text:  data.data1,
                        style: globalTextStyle(
                          fontSize: 12,
                          color: Color(0xFF04063E),
                
                        ),
                       
                      ),
                    ],
                  ),
                ),
                
                RichText(
                  text: TextSpan(
                    text: 'Data 2    : ',
                    style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFF646984),
                    ),
                    children: [
                      TextSpan(
                        text:  data.data2,
                        style: globalTextStyle(
                          fontSize: 12,
                          color: Color(0xFF04063E),
                
                        ),
                       
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Color(0xFF646984),size: 26,),
        ],
      ),
    );
  }
}
