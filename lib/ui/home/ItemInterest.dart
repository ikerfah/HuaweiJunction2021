import 'package:HMSFlutter/core/models/Interest.dart';
import 'package:HMSFlutter/utils/Colors.dart';
import 'package:flutter/material.dart';

class ItemInterest extends StatefulWidget {
  final Interest interest;
  final Function(Interest) onTap;
  final Interest? selectedInterest;

  const ItemInterest({
    Key? key,
    required this.interest,
    required this.onTap,
    this.selectedInterest,
  }) : super(key: key);

  @override
  _ItemInterestState createState() => _ItemInterestState();
}

class _ItemInterestState extends State<ItemInterest> {
  bool isCurrentSelected() {
    return widget.selectedInterest != null &&
        widget.selectedInterest?.id == widget.interest.id;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {widget.onTap(widget.interest)},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          color: Colors.white,
          child: Text(
            "${widget.interest.title}",
            style: TextStyle(
                fontSize: 16.0,
                color: isCurrentSelected() ? kMainColor : grayed,
                fontWeight:
                    isCurrentSelected() ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
