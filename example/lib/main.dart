import 'package:flutter/material.dart';
import 'package:flutter_sanity/flutter_sanity.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:sanity_image_app/sanity_image.dart';

final sanityClient = SanityClient(projectId: "ckszsb2r", dataset: "production");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanity Image Url Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Sanity Image Url Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  Future<dynamic> fetchImage() async {
    var query =
        r"*[_type=='meditation'][0]{..., 'img': {'image': image, 'asset': image.asset->}}";
    var res = await sanityClient.fetch(query);

    return Future.value(res["img"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(title),
            titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Examples:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                    future: fetchImage(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: ErrorWidget(snapshot.error!));
                        }

                        if (snapshot.hasData) {
                          var image = snapshot.data as Map<String, dynamic>;
                          var picture = SanityImage.fromJson(image);

                          return GridView.count(
                              shrinkWrap: true,
                              childAspectRatio: 3 / 2,
                              padding: const EdgeInsets.all(2.0),
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: [
                                Image.network(
                                    urlFor(picture).size(200, 200).url()),
                                Image.network(urlFor(picture).blur(50).url()),
                                const Text("1. size = 200 x 200"),
                                const Text("2. blur = 50"),
                                Image.network(urlFor(picture)
                                    .rect(200, 200, 400, 400)
                                    .url()),
                                Image.network(
                                    urlFor(picture).quality(50).url()),
                                const Text("3. cropped"),
                                const Text("4. quality set to 50"),
                                Image.network(
                                    urlFor(picture).flipHorizontal().url()),
                                Image.network(
                                    urlFor(picture).flipVertical().url()),
                                const Text("5. flipped horizontally"),
                                const Text("6. flipped vertically"),
                              ]);
                        }
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
              ),
            ],
          ),
        ));
  }
}
