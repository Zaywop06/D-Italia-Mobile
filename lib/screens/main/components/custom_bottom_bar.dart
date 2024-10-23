import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomBar extends StatefulWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.index;

    // Escuchar cambios en el TabController
    widget.controller.addListener(() {
      setState(() {
        _currentIndex = widget.controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromRGBO(255, 191, 148, 1),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.home,
                  color: _currentIndex == 0 ? Colors.black : Color.fromRGBO(255, 255, 255, 1), // Color del icono
                ),
                onPressed: () {
                  widget.controller.animateTo(0);
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.list,
                  color: _currentIndex == 1 ? Colors.black : Color.fromRGBO(255, 255, 255, 1), // Color del icono
                ),
                onPressed: () {
                  widget.controller.animateTo(1);
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  color: _currentIndex == 2 ? Colors.black : Color.fromRGBO(255, 255, 255, 1), // Color del icono
                ),
                onPressed: () {
                  widget.controller.animateTo(2);
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.solidUser,
                  color: _currentIndex == 3 ? Colors.black : Color.fromRGBO(255, 255, 255, 1), // Color del icono
                ),
                onPressed: () {
                  widget.controller.animateTo(3);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
