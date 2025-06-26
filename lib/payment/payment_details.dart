import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:juices/payment/order_summary.dart';
import 'package:location/location.dart' as loc;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final String paymentMethod;

  const PaymentDetailsScreen({Key? key, required this.paymentMethod}) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> with SingleTickerProviderStateMixin {
  final _creditCardFormKey = GlobalKey<FormState>();

  String address = '';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final String instapayID = "instapay-123456789";
  final String vodafoneCashNumber = "0100-962-4550";

  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get needsCardDetails => widget.paymentMethod == "Credit Card";
  bool get isInstapay => widget.paymentMethod == "Instapay";
  bool get isVodafoneCash => widget.paymentMethod == "Vodafone Cash";

  Future<void> _pickLocation() async {
    loc.Location location = loc.Location();
    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted != loc.PermissionStatus.granted) return;

    loc.LocationData locationData = await location.getLocation();
    LatLng currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPickerScreen(
          initialLocation: currentLatLng,
          onLocationSelected: (latLng, placeName) {
            setState(() {
              selectedLocation = latLng;
              address = placeName;
            });
          },
        ),
      ),
    );
  }

  Widget buildPaymentInstructions() {
    if (isInstapay) {
      return buildInstructionTile("Instapay", instapayID, Colors.deepPurple);
    } else if (isVodafoneCash) {
      return buildInstructionTile("Vodafone Cash", vodafoneCashNumber, Colors.redAccent);
    } else if (widget.paymentMethod == "Cash") {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cash on Delivery", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("You will pay the delivery agent in cash when you receive your order.", style: TextStyle(color: Colors.grey)),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget buildInstructionTile(String label, String data, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label Instructions:", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text("Send payment to the ID below.", style: TextStyle(color: Colors.grey[700])),
        const SizedBox(height: 10),
        SelectableText(data, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 10),
        Center(
          child: QrImageView(data: data, version: QrVersions.auto, size: 120),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      appBar: AppBar(
        title: const Text("Enter Payment Details",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E3932),
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeIn,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text('Payment Method: ${widget.paymentMethod}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.location_pin),
                      label: Text(address.isEmpty ? "Select Delivery Location" : address),
                      onPressed: _pickLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E3932),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildPaymentInstructions(),
                    const SizedBox(height: 10),
                    const Text("After payment, tap Continue.", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 20),
                    if (needsCardDetails) ...[
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        cardBgColor: Color(0xFF1E3932),
                        showBackView: isCvvFocused,
                        isHolderNameVisible: true,
                        
                        onCreditCardWidgetChange: (_) {},
                        cardType: CardType.visa ,
                                            ),
                       CreditCardForm(
  formKey: _creditCardFormKey,
  cardNumber: cardNumber,
  
  expiryDate: expiryDate,
  cardHolderName: cardHolderName,
  cvvCode: cvvCode,
  onCreditCardModelChange: (data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  },
  isHolderNameVisible: true, // 👈 THIS is required!
  themeColor: Color(0xFF1E3932),
  obscureCvv: true,
  obscureNumber: false,
  cardNumberDecoration: const InputDecoration(
    labelText: 'Number',
    border: OutlineInputBorder(),
  ),
  expiryDateDecoration: const InputDecoration(
    labelText: 'Expired Date',
    border: OutlineInputBorder(),
  ),
  cvvCodeDecoration: const InputDecoration(
    labelText: 'CVV',
    border: OutlineInputBorder(),
  ),
  cardHolderDecoration: const InputDecoration(
    labelText: 'Card Holder',
    border: OutlineInputBorder(),
  ),
)

                     
                     
                    ],
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3932),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 6,
                      ),
                      child: const Text("Continue", style: TextStyle(fontSize: 16,color: Colors.white)),
                      onPressed: () {
                        final valid = needsCardDetails ? _creditCardFormKey.currentState?.validate() ?? false : address.isNotEmpty;
                        if (valid && mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderSummaryScreen(
                                paymentMethod: widget.paymentMethod,
                                address: address,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class LocationPickerScreen extends StatefulWidget {
  final LatLng initialLocation;
  final void Function(LatLng, String) onLocationSelected;

  const LocationPickerScreen({
    required this.initialLocation,
    required this.onLocationSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}
class _LocationPickerScreenState extends State<LocationPickerScreen> {
  latlong2.LatLng? _pickedLocation;

  void _onTap(flutter_map.TapPosition tapPosition, latlong2.LatLng latlng) async {
    setState(() => _pickedLocation = latlng);

    // Reverse geocoding to get address
    List<Placemark> placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    String address = "${placemarks.first.street}, ${placemarks.first.locality}";

    // Convert latlong2.LatLng back to google_maps_flutter LatLng for callback
    widget.onLocationSelected(
      LatLng(latlng.latitude, latlng.longitude),
      address,
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: flutter_map.FlutterMap(
        options: flutter_map.MapOptions(
          center: latlong2.LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 13,
          onTap: _onTap,
        ),
        children: [
          flutter_map.TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (_pickedLocation != null)
            flutter_map.MarkerLayer(
              markers: [
                flutter_map.Marker(
                  point: _pickedLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                )
              ],
            ),
        ],
      ),
    );
  }
}
