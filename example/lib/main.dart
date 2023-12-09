import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity/flutter_sanity.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:sanity_image_app/sanity_image.dart';

final sanityClient = SanityClient(projectId: "gua6su5h", dataset: "production");

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
        r"*[_type=='post'][0..2]{..., 'img': {'image': mainImage, 'asset': mainImage.asset->}}";
    var res = await sanityClient.fetch(query);

    return Future.value(res);
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
              Expanded(
                child: FutureBuilder(
                    future: fetchImage(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: ErrorWidget(snapshot.error!));
                        }

                        if (snapshot.hasData) {
                          var posts = snapshot.data as List;
                          var pictures = posts
                              .map((e) => SanityImage.fromJson(e["img"]))
                              .toList();

                          return ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(2.0),
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Examples:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text:
                                          "This example app is built to showcase the functionality of ",
                                      style: TextStyle(
                                          color: Colors.blueGrey[500]),
                                      children: [
                                        TextSpan(
                                            text: "flutter_sanity_image",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                          text:
                                              " package developed by Techurve with ❤️",
                                        )
                                      ]),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  "I. Use of Sanity Color Palette:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "a. Apply Background Overlay",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  width: 320.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          urlFor(pictures[0]).url()),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          pictures[0]
                                                  .palette
                                                  ?.darkMuted
                                                  .background
                                                  .withOpacity(0.5) ??
                                              Colors.black.withOpacity(0.2),
                                          BlendMode.darken),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    posts[0]["title"],
                                    style: TextStyle(
                                        fontSize: 26,
                                        color:
                                            pictures[0].palette?.dominant.title,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 320.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          urlFor(pictures[1]).url()),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          pictures[1]
                                                  .palette
                                                  ?.dominant
                                                  .background
                                                  .withOpacity(0.5) ??
                                              Colors.black.withOpacity(0.2),
                                          BlendMode.darken),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    posts[1]["title"],
                                    style: TextStyle(
                                        fontSize: 26,
                                        color:
                                            pictures[1].palette?.dominant.title,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "b. Style Text based on Image Colors",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 320.0,
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                urlFor(pictures[1]).url()),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(posts[1]["title"],
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: pictures[1]
                                                .palette
                                                ?.dominant
                                                .background,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  "II. Placeholder Image for Loading:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      urlFor(pictures[0]).size(400, 400).url(),
                                  placeholder: (context, url) =>
                                      ImagePlaceholder(lqip: pictures[0].lqip),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  "III. Image Transformations:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  "a. size = 200 x 200",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                    urlFor(pictures[1]).size(200, 200).url()),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "b. blur = 50",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                    urlFor(pictures[1]).blur(50).url()),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "c. cropped",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(urlFor(pictures[0])
                                    .rect(200, 200, 400, 400)
                                    .url()),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "d. flipped horizontally",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                    urlFor(pictures[1]).flipHorizontal().url()),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "e. flipped vertically",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                    urlFor(pictures[1]).flipVertical().url()),
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
