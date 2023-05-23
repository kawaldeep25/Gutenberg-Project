import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guten/data/model/books_list.dart' as books;
import 'package:guten/data/providers/booklist_provider.dart';
import 'package:guten/ui/screens/book_list.dart';
import 'package:guten/utils/constants/responsive_constant.dart';
import 'package:guten/utils/theme/app_assets.dart';
import 'package:guten/utils/theme/app_colours.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, this.category}) : super(key: key);
  String? category;
  static const ROUTE_NAME = 'CategoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  UnrestrictedProvider? _booklistProvider;
  String query = '';
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooksByGenre(widget.category!);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _booklistProvider!.getMoreBooks();
      }
    });
  }

  getBooksByGenre(String category) async {
    print('cat is $category');
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    Future.microtask(
        () => context.read<UnrestrictedProvider>().getBooksByGenre(category));
    // _booklistProvider!.getBooksByGenre(category);
    // });
  }

  void searchBooks() async {
    _booklistProvider!.clearSearch();
  }

  void searchQuery(String query) async {
    _booklistProvider!.onSearchFunction(query);
  }

  @override
  void didChangeDependencies() {
    _booklistProvider = Provider.of<UnrestrictedProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
        backgroundColor: themeData.scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: themeData.scaffoldBackgroundColor,
          centerTitle: false,
          title: Text(
            widget.category!,
            style: themeData.textTheme.headline4!.copyWith(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: AppColors.grey,
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  filled: true,
                  fillColor: AppColors.fadedGrey,
                  focusColor: AppColors.fadedGrey,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.search,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: query.isNotEmpty
                      ? InkWell(
                          child: SvgPicture.asset(
                            AppAssets.cancel,
                            fit: BoxFit.none,
                          ),
                          onTap: () {
                            controller.clear();
                            query = '';
                            searchBooks();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      query = '';
                    });
                    query = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    query = value;
                  });
                  query.isEmpty ? searchBooks() : searchQuery(query);
                },
              ),
            ),
            preferredSize: const Size.fromHeight(70),
          ),
        ),
        body: _booklistProvider == null
            ? Container(
                height: 100 * SizeConfig.heightMultiplier! / 1.65,
                margin: const EdgeInsets.only(top: 35, right: 0),
                child: const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                )))
            : products(_booklistProvider));
  }

  Widget products(UnrestrictedProvider? bloc) {
    if (bloc!.todoActionState == ResourceStatus.Failure) {
      return Container(
          margin:
              EdgeInsets.only(top: 3 * SizeConfig.heightMultiplier!, right: 0),
          height: MediaQuery.of(context).size.height / 1.35,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Failed to load data',
                      style: TextStyle(
                        fontSize: 2.1 * SizeConfig.heightMultiplier!,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.textMultiplier!,
                ),
                InkWell(
                    onTap: () {
                      getBooksByGenre(widget.category!);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.textMultiplier! * 1.75),
                      ),
                      child: Container(
                        // margin: EdgeInsets.only(top: SizeConfig.textMultiplier!),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.textMultiplier! * 1.75),
                          color: Colors.blueGrey,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.textMultiplier! * 3,
                            vertical: SizeConfig.textMultiplier!),
                        child: Text(
                          "Retry",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textMultiplier! * 2),
                        ),
                      ),
                    ))
              ],
            ),
          ));
    }

    if (bloc.todoActionState == ResourceStatus.Success) {
      return buildDataWidget(
        context,
        widget.category!,
        bloc.booksListResult,
      );
    }

    return SizeConfig.isPortrait
        ? GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: SizeConfig.isStandardScreen! ? 3 : 3,
              childAspectRatio: SizeConfig.isStandardScreen! ? 0.5 : 0.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: double.infinity,
                  height: 25 * SizeConfig.heightMultiplier!,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 18 * SizeConfig.heightMultiplier!,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.textMultiplier!),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.textMultiplier! * 0.5,
                                vertical: SizeConfig.textMultiplier! * 1),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier!,
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.textMultiplier!),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.textMultiplier! * 0.75),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier!,
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.textMultiplier! * 0.75,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ],
                      )));
            })
        : GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              childAspectRatio: SizeConfig.isStandardScreen! ? 0.5 : 0.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: double.infinity,
                  height: 25 * SizeConfig.heightMultiplier!,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20 * SizeConfig.heightMultiplier!,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.textMultiplier!),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.textMultiplier! * 0.5,
                                vertical: SizeConfig.textMultiplier! * 1),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.textMultiplier!),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.textMultiplier! * 0.75),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.textMultiplier! * 0.75,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ],
                      )));
            });
  }

  Widget buildDataWidget(
      BuildContext context, String genreTitle, books.BookList? booksData) {
    return ChangeNotifierProvider<UnrestrictedProvider>.value(
        value: _booklistProvider!,
        child: BookList(
          booklistProvider: _booklistProvider,
          scrollController: _scrollController,
        ));
  }
}
