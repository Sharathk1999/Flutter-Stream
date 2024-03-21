import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_stream/core/common/widgets/custom_loader.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/core/utils/pick_image.dart';
import 'package:flutter_stream/core/utils/show_snackbar.dart';
import 'package:flutter_stream/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_stream/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_stream/features/blog/presentation/widgets/blog_editor_textfield.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUploadEvent(
              posterId: posterId,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.chevron_left_circle,
            color: AppPallete.borderColor,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: const Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              color: AppPallete.gradient3,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailureState) {
            showSnackBar(context, state.error, "Something went wrong..!", ContentType.failure);
          } else if(state is BlogSuccessState){
            Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const LoaderWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              color: AppPallete.gradient3,
                              strokeCap: StrokeCap.round,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(12),
                              borderType: BorderType.RRect,
                              child: SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.folder_open,
                                      color: AppPallete.gradient3,
                                      size: 35,
                                    ),
                                    Text(
                                      "Select your image.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: AppPallete.gradient3),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Dart",
                          "Flutter",
                          "Widgets",
                          "State Management",
                        ]
                            .map(
                              (topic) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(topic)) {
                                      selectedTopics.remove(topic);
                                    } else {
                                      selectedTopics.add(topic);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    side: selectedTopics.contains(topic)
                                        ? null
                                        : const BorderSide(
                                            color: AppPallete.gradient3,
                                          ),
                                    color: selectedTopics.contains(topic)
                                        ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    label: Text(
                                      topic,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlogEditorTextField(
                        controller: titleController,
                        hintText: "Title for your blog."),
                    const SizedBox(
                      height: 15,
                    ),
                    BlogEditorTextField(
                        controller: contentController,
                        hintText: "Content for your blog."),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
