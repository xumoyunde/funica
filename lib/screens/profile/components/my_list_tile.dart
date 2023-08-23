import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final Widget leading;
  final Widget? trailing;
  final String title;
  final String? subTitle;
  final Function()? click;
  final Color? color;

  const MyListTile(
      {super.key,
      required this.leading,
      required this.trailing,
      required this.title,
      this.subTitle,
      this.click,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              child: leading,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  subTitle == null
                      ? SizedBox()
                      : Text(
                          subTitle!,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}
