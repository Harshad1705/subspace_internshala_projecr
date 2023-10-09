import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace_internshala_projecr/data/models/blog_model.dart';
import 'package:subspace_internshala_projecr/login/cubits/blog_cubit/blog_cubit.dart';
import 'package:subspace_internshala_projecr/presentation/screens/blog_page.dart';

import '../../login/cubits/blog_cubit/blog_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Blogs',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<BlogCubit, BlogState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is BlogInitialState || state is BlogLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BlogLoadedState) {
              final blogs = state.blogs;
              return buildBlogView(blogs);
            }
            if (state is BlogErrorState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                child: Text(state.error ,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                  color: Colors.white,
                ),),
              );
            }
            return const Center(
              child: Text(
                "Nothing Here",
              ),
            );
          },
        ),
      ),
    );
  }

  ListView buildBlogView(List<Blog> blogs) {
    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlogPage(blog: blog),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff2B2B2B),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          blog.imageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Text(
                    blog.title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
