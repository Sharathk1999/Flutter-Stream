import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/core/utils/show_snackbar.dart';
import 'package:flutter_stream/features/blog/domain/entities/blog.dart';

import '../../../../core/utils/time_ago.dart';

class BlogViewPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewPage(
          blog: blog,
        ),
      );
  final Blog blog;

  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Blog Details'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'By ${blog.posterName ?? "Anonymous"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ],
                ),
                Text( 
                  'Posted ${timeAgo(blog.updatedAt)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppPallete.whiteColor.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 16.0),
                SelectableText(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPallete.borderColor,
        onPressed: () {
          // Copy blog content to clipboard
          Clipboard.setData(ClipboardData(text: blog.content));
          showSnackBar(context, "Content copied to clipboard.", "Copied",
              ContentType.success);
        },
        child: const Icon(Icons.copy),
      ),
    );
  }
}
