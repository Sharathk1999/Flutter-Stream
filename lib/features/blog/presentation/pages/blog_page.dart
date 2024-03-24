import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/common/widgets/custom_loader.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/core/utils/show_snackbar.dart';
import 'package:flutter_stream/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_stream/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_stream/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_stream/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_stream/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter_stream/features/blog/presentation/widgets/blog_card_widget.dart';
import 'package:sidebarx/sidebarx.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Stream",
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
      drawer: SidebarX(
        controller: SidebarXController(selectedIndex: 0, extended: true),
        theme: const SidebarXTheme(
          width: 120,
          hoverColor: AppPallete.gradient1,
          selectedIconTheme: IconThemeData(color: AppPallete.gradient1,),
          iconTheme: IconThemeData(color: AppPallete.borderColor,),
          textStyle: TextStyle(color: Colors.white38),
          padding: EdgeInsets.only(top: 15),
          selectedTextStyle: TextStyle(color: Colors.white),
          itemTextPadding: EdgeInsets.symmetric(horizontal: 5),
          selectedItemTextPadding:  EdgeInsets.symmetric(horizontal: 5),
        ),
        items:  [
          SidebarXItem(
            icon: Icons.exit_to_app_rounded,
            label: 'Logout',
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutEvent());
              Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
            },
          ),
          SidebarXItem(
            icon: CupertinoIcons.info_circle_fill,
            label: 'Info',
            onTap: () {
              
              // todo: Add an info page here 
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailureState) {
            showSnackBar(
                context, state.error, "Error Occurred", ContentType.failure);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const LoaderWidget();
          }
          if (state is BlogDisplaySuccessState) {
            final blogs = state.blogs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, BlogViewPage.route(blog));
                  },
                  child: BlogCard(
                    blog: blog,
                    color: AppPallete.borderColor,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
