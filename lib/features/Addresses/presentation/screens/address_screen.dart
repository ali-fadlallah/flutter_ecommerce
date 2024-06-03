import 'dart:typed_data';

import 'package:flutter_ecommerce_app/core/reusable_components/custom_profile_text_field.dart';

import '../../../../core/global/global_imports.dart';

class AddressScreen extends StatefulWidget {
  final String addressName;
  final String addressThoroughfare;
  final String addressAdministrativeArea;
  final String addressSubAdministrativeArea;
  final Uint8List? imageBytes;
  final LatLng position;

  AddressScreen(
      {super.key,
      this.imageBytes,
      required this.position,
      required this.addressName,
      required this.addressThoroughfare,
      required this.addressAdministrativeArea,
      required this.addressSubAdministrativeArea});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController addressName = TextEditingController();
  final TextEditingController streetName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController buildingNo = TextEditingController();
  final TextEditingController floorNo = TextEditingController();
  final TextEditingController apartmentNo = TextEditingController();

  final TextEditingController landmark = TextEditingController();

  bool checkedValue = false; // Initialize the checkedValue

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressName.dispose();
    streetName.dispose();
    phoneNumber.dispose();
    buildingNo.dispose();
    floorNo.dispose();
    apartmentNo.dispose();
    landmark.dispose();
  }

  @override
  void initState() {
    super.initState();
    streetName.text = [
      widget.addressSubAdministrativeArea ?? '', // Handle null cases if needed
      if (widget.addressThoroughfare.isNotEmpty) widget.addressThoroughfare
    ].where((element) => element.isNotEmpty).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.confirmAddress),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Name: ${widget.addressName.isEmpty ? "N/A" : widget.addressName} \n Thoroughfare: ${widget.addressThoroughfare.isEmpty ? "N/A" : widget.addressThoroughfare} \nAddressAdministrativeArea: ${widget.addressAdministrativeArea.isEmpty ? "N/A" : widget.addressAdministrativeArea}\naddressSubAdministrativeArea: ${widget.addressSubAdministrativeArea.isEmpty ? "N/A" : widget.addressSubAdministrativeArea}',
            //   style: TextStyle(fontSize: 18),
            // ),
            widget.imageBytes != null
                ? SizedBox(
                    height: 200.h,
                    child: Stack(
                      children: [
                        Image.memory(
                          widget.imageBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200.h,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(AppLocalizations.of(context)!.yourLocationHere, style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text('No Image Available'),
                  ),
            // SizedBox(
            //   height: 10.h,
            // ),
            Padding(
              padding: REdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomProfileTextField(
                    labelText: AppLocalizations.of(context)!.addressName,
                    controller: addressName,
                    validator: (p0) {},
                  ),
                  CustomProfileTextField(
                    labelText: AppLocalizations.of(context)!.streetName,
                    controller: streetName,
                    validator: (p0) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomProfileTextField(
                          labelText: AppLocalizations.of(context)!.phoneNumber,
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          validator: (p0) {},
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: CustomProfileTextField(
                          labelText: AppLocalizations.of(context)!.buildingNo,
                          controller: buildingNo,
                          validator: (p0) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomProfileTextField(
                          labelText: AppLocalizations.of(context)!.floorNumber,
                          controller: floorNo,
                          keyboardType: TextInputType.number,
                          validator: (p0) {},
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: CustomProfileTextField(
                          labelText: AppLocalizations.of(context)!.apartmentNo,
                          controller: apartmentNo,
                          validator: (p0) {},
                        ),
                      ),
                    ],
                  ),
                  CustomProfileTextField(
                    labelText: AppLocalizations.of(context)!.landmark,
                    controller: landmark,
                    validator: (p0) {},
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checkedValue,
                        onChanged: (bool? newValue) {
                          setState(() {
                            checkedValue = newValue ?? false; // Handle null case
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.makeAsDefaultAddress,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
