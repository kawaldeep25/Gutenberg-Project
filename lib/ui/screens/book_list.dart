import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guten/data/providers/booklist_provider.dart';
import 'package:guten/utils/snackbar.dart';
import 'package:guten/utils/theme/app_textstyles.dart';

import '../../utils/constants/size_config.dart';

class BookList extends StatelessWidget {
  BookList({Key? key, this.booklistProvider, this.scrollController})
      : super(key: key);
  final UnrestrictedProvider? booklistProvider;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final snackbar = SnackBar(
      elevation: 10,
      backgroundColor: const Color(0xFFF0F0F6),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: themeData.errorColor,
          style: BorderStyle.solid,
          width: 5,
        ),
      ),
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: themeData.errorColor,
            size: 5 * SizeConfig.heightMultiplier!,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'No viewable version available!',
            style: themeData.textTheme.subtitle2!.copyWith(
              color: themeData.errorColor,
              fontSize: 2 * SizeConfig.heightMultiplier!,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.fixed,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: SizeConfig.isStandardScreen! ? 10 : 5,
      ),
    );
    return Column(
      children: [
        if (booklistProvider!.getBooksList.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: SizeConfig.isStandardScreen! ? 75 : 65,
                    color: themeData.errorColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "No Books Found!",
                      style: themeData.textTheme.headline5!.copyWith(
                        color: themeData.errorColor,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (booklistProvider!.getBooksList.isNotEmpty)
          //OrientationBuilder(builder: (context, orientation) {}
          Expanded(
            child: GridView.custom(
              controller: scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: SizeConfig.isPortrait ? 3 : 6,
                childAspectRatio: SizeConfig.isStandardScreen! ? 0.5 : 0.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
              ),
              childrenDelegate: SliverChildListDelegate(
                booklistProvider!.getBooksList.map(
                  (
                    book,
                  ) {
                    return InkWell(
                      onTap: () async {
                        var canOpen =
                            await booklistProvider!.getBookDetails(book!.id);
                        if (!canOpen) {
                          context.showSnackBar(
                              'No viewable version available.', Colors.red);
                        }
                      },
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: 3),
                        color: themeData.accentColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            book!.formats.imageJpeg != ''
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              211, 209, 238, 0.5),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      book.formats.imageJpeg,
                                      scale: 1,
                                      height: SizeConfig.isStandardScreen!
                                          ? 20 * SizeConfig.heightMultiplier!
                                          : 15 * SizeConfig.heightMultiplier!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: SizeConfig.isStandardScreen!
                                        ? 15 * SizeConfig.heightMultiplier!
                                        : 10 * SizeConfig.heightMultiplier!,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              211, 209, 238, 0.5),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: const Color(0xFFA0A0A0),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFF0F0F6),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        booklistProvider!.getAssetByGenre(),
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, bottom: 4.0),
                                child: Text(
                                  book.title.toUpperCase(),
                                  style: AppTextStyles.bookName.copyWith(
                                    // color: Color(0xFF333333),
                                    color: Colors.black,
                                    fontFamily: "Montserrat_SemiBold",
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, bottom: 4.0),
                                child: Text(
                                  book.authors.isNotEmpty
                                      ? book.authors.first != null
                                          ? book.authors.first.name
                                          : ''
                                      : '',
                                  style: AppTextStyles.bookAuthor.copyWith(
                                    color: const Color(0xFFA0A0A0),
                                    fontFamily: "Montserrat_SemiBold",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        if (booklistProvider!.pageLoader)
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 10),
            child: const Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ),
            ),
          ),
      ],
    );
  }
}
