import 'package:flutter/material.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

class DirectionContent extends StatelessWidget {
  const DirectionContent({
    super.key,
    required this.address,
    this.onTap,
  });

  final Address address;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Card(
      shadowColor: MyColors.violetBlue,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.dp(2),
          vertical: responsive.dp(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              icon: Icons.location_on,
              label: "Dirección",
              value: address.address,
              responsive: responsive,
            ),
            _divider(responsive),

            // Aquí agregamos la fila con la ciudad y el icono de basura
            Padding(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(0.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_city,
                      color: MyColors.violetBlue, size: responsive.dp(3)),
                  SizedBox(width: responsive.wp(3)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ciudad",
                          style: TextStyles.dynamicTextStyle(
                            isBold: true,
                            fontFamily: Fonts.mPLUSRounded1cMedium,
                            fontSize: responsive.fp(14),
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: responsive.hp(0.2)),
                        Text(
                          address.city,
                          style: TextStyles.dynamicTextStyle(
                            fontFamily: Fonts.mPLUSRounded1cMedium,
                            fontSize: responsive.fp(16),
                            color: MyColors.violetBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    key: const Key('delete_button'),
                    onTap: onTap,
                    child: Icon(
                      Icons.delete,
                      color: MyColors.red.withAlpha((0.7 * 255).toInt()),
                      size: responsive.dp(3),
                    ),
                  ),
                ],
              ),
            ),

            _divider(responsive),
            _buildInfoRow(
              icon: Icons.map,
              label: "Departamento",
              value: address.state,
              responsive: responsive,
            ),
            _divider(responsive),
            _buildInfoRow(
              icon: Icons.local_post_office,
              label: "Código Postal",
              value: address.zipCode,
              responsive: responsive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Responsive responsive,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.hp(0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: MyColors.violetBlue, size: responsive.dp(3)),
          SizedBox(width: responsive.wp(3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.dynamicTextStyle(
                    isBold: true,
                    fontFamily: Fonts.mPLUSRounded1cMedium,
                    fontSize: responsive.fp(14),
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: responsive.hp(0.2)),
                Text(
                  value,
                  style: TextStyles.dynamicTextStyle(
                    fontFamily: Fonts.mPLUSRounded1cMedium,
                    fontSize: responsive.fp(16),
                    color: MyColors.violetBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.hp(0.2)),
      child: Divider(
        color: MyColors.violetBlue.withAlpha((0.3 * 255).toInt()),
        thickness: 0.8,
      ),
    );
  }
}
