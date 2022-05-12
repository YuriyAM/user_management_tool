import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:user_management_tool/providers/FileProvider.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: FileProvider.load("README.md"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('Cannot retrieve data from database'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const SizedBox(
                        width: 500,
                        child: ListTile(
                          onTap: null,
                          minLeadingWidth: 0,
                          leading: Icon(Icons.info),
                          title: Text(
                            "Info page",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 500,
                        child: Markdown(
                          data: snapshot.data!,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        )),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Text('Error'); // error
          } else {
            return const CircularProgressIndicator(); // loading
          }
        });
  }
}
