import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:ship_dashboard/app/modules/user/presentation/stores/logged_user_store.dart';
import 'package:ship_dashboard/app/shared/constants.dart';
import 'package:ship_dashboard/responsive.dart';

import '../home_controller.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Modular.get<HomeController>();
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: homeController.controlMenu,
          ),
        if (!Responsive.isMobile(context))
          RxBuilder(builder: (context) {
            return Text(
              homeController.headText,
              style: Theme.of(context).textTheme.headline6,
            );
          }),
        if (!Responsive.isMobile(context)) Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LoggedUserStore>();
    final user = store.state;
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: user.imageUrl ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 38,
            ),
          ),
          SizedBox(width: 7),
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(user.name),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
