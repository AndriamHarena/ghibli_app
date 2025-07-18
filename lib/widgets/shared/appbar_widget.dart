import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget  {
  final bool showBackButton;
  
  const AppbarWidget({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/logo.webp', height: 40,),
      automaticallyImplyLeading: !showBackButton,
      leading: showBackButton 
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          )
        : null,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(55);
}