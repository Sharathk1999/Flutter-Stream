import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';

class AddNewBlogPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder: (context) => const AddNewBlogPage(),);
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              color: AppPallete.gradient3,
            ),
          ),
        ],
      ),
    );
  }
}