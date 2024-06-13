import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDisplay extends StatelessWidget {
  final String address;

  AddressDisplay({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.pink,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              address,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
