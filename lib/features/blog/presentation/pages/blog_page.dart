import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/features/blog/presentation/pages/add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Flutter Stream",style: Theme.of(context).textTheme.titleMedium,),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(
              CupertinoIcons.add_circled_solid,
              color: AppPallete.gradient3,
            ),
          ),
        ],
      ),
    );
  }
}
