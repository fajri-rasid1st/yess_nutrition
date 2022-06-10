import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/data/models/categories.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoriMakananMinuman.length,
        itemBuilder: (context, index) => CategoryCardMakananMinuman(
          img: categoriMakananMinuman[index].img,
          title: categoriMakananMinuman[index].title,
          press: () {},
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(width: defaultPadding),
      ),
    );
  }
}

class CategoryCardMakananMinuman extends StatelessWidget {
  const CategoryCardMakananMinuman({
    Key? key,
    required this.img,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String img, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(150, 150),
        backgroundColor: primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
        child: Column(
          children: [
            Image.asset(
              img,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: defaultPadding / 4),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontFamily: font, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
