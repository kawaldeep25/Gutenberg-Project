import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guten/data/model/genre.dart';
import 'package:guten/ui/screens/category/category_screen.dart';
import 'package:guten/utils/constants/size_config.dart';
import 'package:guten/utils/constants/strings.dart';
import 'package:guten/utils/theme/app_assets.dart';
import 'package:guten/utils/theme/app_colours.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  static const ROUTE_NAME = 'Home';
  final List<Genre> genreList = [
    Genre(AppAssets.fiction, Strings.fiction),
    Genre(AppAssets.drama, Strings.drama),
    Genre(AppAssets.humour, Strings.humour),
    Genre(AppAssets.politics, Strings.politics),
    Genre(AppAssets.philosophy, Strings.philosophy),
    Genre(AppAssets.history, Strings.history),
    Genre(AppAssets.adventure, Strings.adventure),
  ];
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: themeData.accentColor,
          body: SingleChildScrollView(
            child: !SizeConfig.isPortrait
                ? Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: 17 * SizeConfig.heightMultiplier!,
                            width: double.infinity,
                            // color: Colors.amber,
                            child: SvgPicture.asset(
                              AppAssets.pattern,
                              fit: BoxFit.cover,
                              height: SizeConfig.isStandardScreen!
                                  ? SizeConfig.screenHeight! / 3
                                  : SizeConfig.screenHeight! / 2.6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 35.0, 20.0, 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      Strings.gutenberg,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Strings.project,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  Strings.homeDesc,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier!,
                      ),
                      GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 6),
                          itemCount: genreList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    CategoryScreen.ROUTE_NAME,
                                    arguments: genreList[index].genreTitle,
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: SizeConfig.isStandardScreen!
                                          ? SizeConfig.heightMultiplier!
                                          : 7,
                                      horizontal: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            genreList[index].genreIcon!,
                                            height: 3 *
                                                SizeConfig.heightMultiplier!,
                                            fit: BoxFit.contain,
                                            width:
                                                3 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.heightMultiplier!,
                                        ),
                                        Text(
                                          genreList[index].genreTitle!,
                                          style: TextStyle(
                                            color: const Color(0xFF333333),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 2.75 *
                                                SizeConfig.heightMultiplier!,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            AppAssets.next,
                                            height: 2 *
                                                SizeConfig.heightMultiplier!,
                                            fit: BoxFit.contain,
                                            width:
                                                2 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          })
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: 27 * SizeConfig.heightMultiplier!,
                            width: double.infinity,
                            // color: Colors.amber,
                            child: SvgPicture.asset(
                              AppAssets.pattern,
                              fit: BoxFit.cover,
                              height: SizeConfig.isStandardScreen!
                                  ? SizeConfig.screenHeight! / 3
                                  : SizeConfig.screenHeight! / 2.6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 35.0, 20.0, 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Strings.gutenberg,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                Text(
                                  Strings.project,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  Strings.homeDesc,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier!,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: genreList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    CategoryScreen.ROUTE_NAME,
                                    arguments: genreList[index].genreTitle,
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: SizeConfig.isStandardScreen!
                                          ? SizeConfig.heightMultiplier!
                                          : 7,
                                      horizontal: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            genreList[index].genreIcon!,
                                            height: 3 *
                                                SizeConfig.heightMultiplier!,
                                            fit: BoxFit.contain,
                                            width:
                                                3 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.heightMultiplier!,
                                        ),
                                        Text(
                                          genreList[index].genreTitle!,
                                          style: TextStyle(
                                            color: const Color(0xFF333333),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 2.75 *
                                                SizeConfig.heightMultiplier!,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            AppAssets.next,
                                            height: 2 *
                                                SizeConfig.heightMultiplier!,
                                            fit: BoxFit.contain,
                                            width:
                                                2 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          })
                    ],
                  ),
          ),
        ));
  }
}
