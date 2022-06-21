// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:book_library_flutter/providers/api.dart';
import 'package:book_library_flutter/screens/detailed_screen.dart';

import '../models/book.dart';

List<Color> colors = [
  const Color.fromRGBO(244, 191, 191, 1),
  const Color.fromRGBO(255, 217, 192, 1),
  const Color.fromRGBO(255, 230, 230, 1),
  const Color.fromRGBO(250, 240, 215, 1),
  const Color.fromRGBO(194, 222, 209, 1),
  const Color.fromRGBO(242, 209, 209, 1),
];

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    if (isInit) {
      context.read<Api>().fetchData('title');
      isInit = false;
    }

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: context.watch<Api>().isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Sort',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              context.read<Api>().fetchData('title');
                            },
                            child: const Text('Title'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<Api>().fetchData('genre');
                            },
                            child: const Text('Genre'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Library',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height * 0.5,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: context.read<Api>().books.length,
                        // itemCount: ,
                        itemBuilder: (context, index) => BookCard(
                          index: index,
                          book: context.read<Api>().books[index],
                          size: size,
                        ),
                        // children: [
                        //   BookCard(size: size),
                        //   BookCard(size: size),
                        //   BookCard(size: size),
                        //   BookCard(size: size),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.size,
    required this.book,
    required this.index,
  }) : super(key: key);

  final Size size;
  final Book book;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => DetailedScreen(
                    selectedIndex: index,
                  )),
            ),
          )),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                ),
                width: size.width * 0.52,
                height: size.height * 0.25,
                child: const SizedBox(),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    book.image1,
                    width: size.width * 0.4,
                    height: size.height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  book.genre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://www.adazing.com/wp-content/uploads/2019/02/open-book-clipart-03.png',
          fit: BoxFit.cover,
          width: 75,
          height: 75,
        ),
        title: const Text('book title'),
        subtitle: const Text('genre'),
      ),
    );
  }
}
