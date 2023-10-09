import 'dart:convert';
import 'package:subspace_internshala_projecr/data/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogRepository {

  Future<List<Blog>> fetchPosts() async {

    try {
      final response = await http.get(
        Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs'),
        headers: {
          'x-hasura-admin-secret':
              '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
        },
      );

      final List<dynamic> jsonData = json.decode(response.body)['blogs'];
      final List<Blog> blogs =
          jsonData.map((json) => Blog.fromJson(json)).toList();
      return blogs;
    } catch (ex) {
      throw ex;
    }
  }
}
