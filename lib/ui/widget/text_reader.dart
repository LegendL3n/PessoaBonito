import 'package:flutter/material.dart';
import 'package:pessoa_bonito/service/arquivo_pessoa_service.dart';
import 'package:pessoa_bonito/ui/bonito_theme.dart';

class TextReader extends StatelessWidget {
  final ArquivoPessoaService service;
  final PessoaCategory? currentCategory;
  final PessoaText currentText;

  const TextReader(
      {Key? key,
      required this.service,
      required this.currentCategory,
      required this.currentText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: service.fetchText(currentText),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) return Text("Error ${snapshot.error}");

          if (!snapshot.hasData) return CircularProgressIndicator();

          final fetchedText = snapshot.data as PessoaText;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Center(
                      child: getCategoryWidget(
                          currentCategory?.title ?? 'Índice')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16.0),
                  child: getTitleWidget(fetchedText.title),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: getTextWidget(fetchedText.content ?? 'NO TEXT'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: getAuthorWidget(fetchedText.author ?? 'NO AUTHOR'),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget getCategoryWidget(String title) => Text(
        title,
        style: bonitoTextTheme.subtitle1,
      );

  Widget getTitleWidget(String title) => Text(
        title,
        style: bonitoTextTheme.headline5,
      );

  Widget getTextWidget(String content) => Text(
        content,
        textAlign: TextAlign.left,
        style: bonitoTextTheme.bodyText2,
      );

  Widget getAuthorWidget(String author) => Text(
        author,
        style: bonitoTextTheme.subtitle2,
      );
}
