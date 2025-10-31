import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';// Import for date formatting
import '../../getx_controller/Searchhostel_getx_contoller/Searchhostel_getx_contoller.dart';

// --- Styling Constants ---
// A modern primary color
const Color kPrimaryColor = Colors.blue;
const Color kAccentColor = Colors.blueAccent;
const Color kTextColor = Colors.black87;
const Color kHintColor = Colors.black38;

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({Key? key}) : super(key: key);

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int rooms = 1;
  int adults = 2;
  int children = 0;
  String searchQuery = ''; // Use empty string for better UX if not required
  String accommodationType = 'hotel';
  double lowPrice = 5000; // Adjusted default low price for better range feel
  double highPrice = 150000; // Adjusted default high price
  double maxPrice = 300000;
  String currency = 'INR';

  final TextEditingController _hotelIdController = TextEditingController(text: 'qyhZqzVt');

  final List<String> accommodationOptions = [
    "all", "hotel", "resort", "Boat House", "bedAndBreakfast",
    "guestHouse", "Holidayhome", "cottage", "apartment",
    "Home Stay", "hostel", "Camp_sites/tent", "co_living",
    "Villa", "Motel", "Capsule Hotel", "Dome Hotel"
  ];

  @override
  void initState() {
    super.initState();
    searchQuery = _hotelIdController.text;
    _hotelIdController.addListener(_onHotelIdChange);
    // Initialize dates to tomorrow and day after for a good default UX
    checkInDate = DateTime.now().add(const Duration(days: 1));
    checkOutDate = DateTime.now().add(const Duration(days: 2));
  }

  void _onHotelIdChange() {
    searchQuery = _hotelIdController.text.isNotEmpty ? _hotelIdController.text : '';
  }

  @override
  void dispose() {
    _hotelIdController.removeListener(_onHotelIdChange);
    _hotelIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime initialDate = isCheckIn
        ? (checkInDate ?? DateTime.now().add(const Duration(days: 1)))
        : (checkOutDate ?? (checkInDate ?? DateTime.now()).add(const Duration(days: 1)));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(DateTime.now())
          ? DateTime.now().add(const Duration(days: 1))
          : initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: kTextColor, // Body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          // Ensure checkout date is valid
          if (checkOutDate != null &&
              (checkOutDate!.isBefore(picked) || checkOutDate!.isAtSameMomentAs(picked))) {
            checkOutDate = picked.add(const Duration(days: 1));
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  void _performSearch() {
    // Validate dates
    if (checkInDate == null || checkOutDate == null) {
      Get.snackbar(
        "Error",
        "Please select **Check-in** and **Check-out** dates",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      return;
    }

    // Validate date order
    if (checkOutDate!.isBefore(checkInDate!) ||
        checkOutDate!.isAtSameMomentAs(checkInDate!)) {
      Get.snackbar(
        "Error",
        "Check-out date must be **after** check-in date",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      return;
    }

    // Use a temporary variable for the search query to ensure a valid array is passed
    final List<String> searchQueries = searchQuery.isEmpty ? [] : [searchQuery];

    // Create controller and perform search
    final searchController = Get.put(SearchhotelGetx());
    searchController.searchhostal(
      checkInDate!.toIso8601String().split('T').first,
      checkOutDate!.toIso8601String().split('T').first,
      rooms,
      adults,
      children,
      searchQueries.isEmpty ? "defaultSearch" : "hotelIdSearch", // Dynamic search type
      searchQueries,
      [accommodationType],
      ['street'], // Excluded search types - kept as is
      highPrice.toStringAsFixed(0),
      lowPrice.toStringAsFixed(0),
    );
  }

  // --- Custom Widget for Date Input ---
  Widget _buildDateInput({required bool isCheckIn}) {
    final date = isCheckIn ? checkInDate : checkOutDate;
    final label = isCheckIn ? "CHECK-IN" : "CHECK-OUT";
    final icon = isCheckIn ? Icons.calendar_today : Icons.calendar_month;

    return Expanded(
      child: InkWell(
        onTap: () => _selectDate(context, isCheckIn),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(icon, size: 20, color: kTextColor),
                  const SizedBox(width: 8),
                  Text(
                    date == null
                        ? 'Select Date'
                        : DateFormat('dd MMM, yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Custom Widget for Counter/Slider ---
  Widget _buildCounterInput({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
    required int min,
    required int max,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kPrimaryColor),
              const SizedBox(width: 8),
              Text(
                "$label: $value",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ],
          ),
          Slider(
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            value: value.toDouble(),
            activeColor: kPrimaryColor,
            inactiveColor: kPrimaryColor.withOpacity(0.3),
            label: "$value",
            onChanged: (val) => onChanged(val.toInt()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text(
          "🏨 Find Your Stay",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey.shade50, // Light background for contrast
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // --- 1. Hotel ID / Location Search ---
              TextField(
                controller: _hotelIdController,
                decoration: InputDecoration(
                  labelText: "Hotel ID / City / Area (Optional)",
                  hintText: "e.g., qyhZqzVt or New York",
                  prefixIcon: const Icon(Icons.location_on_outlined, color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  // Handled via controller listener, but kept for immediate use if needed
                },
              ),
              const SizedBox(height: 18),

              // --- 2. Date Selection (Custom Widgets) ---
              Row(
                children: [
                  _buildDateInput(isCheckIn: true),
                  const SizedBox(width: 12),
                  _buildDateInput(isCheckIn: false),
                ],
              ),
              const SizedBox(height: 18),

              // --- 3. Guest and Room Counters ---
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildCounterInput(
                      label: "Rooms",
                      value: rooms,
                      onChanged: (val) => setState(() => rooms = val),
                      min: 1,
                      max: 10,
                      icon: Icons.meeting_room,
                    ),
                    _buildCounterInput(
                      label: "Adults",
                      value: adults,
                      onChanged: (val) => setState(() => adults = val),
                      min: 1,
                      max: 10,
                      icon: Icons.person,
                    ),
                    _buildCounterInput(
                      label: "Children",
                      value: children,
                      onChanged: (val) => setState(() => children = val),
                      min: 0,
                      max: 10,
                      icon: Icons.child_care,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // --- 4. Accommodation Type Dropdown ---
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Accommodation Type",
                  labelStyle: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                  prefixIcon: const Icon(Icons.category, color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: accommodationType,
                items: accommodationOptions
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: kTextColor)),
                ))
                    .toList(),
                onChanged: (val) => setState(() => accommodationType = val!),
              ),
              const SizedBox(height: 18),

              // --- 5. Price Range Slider ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                    child: Text(
                      "Price Range",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                  ),
                  Text(
                    "₹${NumberFormat('#,##,###').format(lowPrice.toInt())} - ₹${NumberFormat('#,##,###').format(highPrice.toInt())}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  RangeSlider(
                    min: 0,
                    max: maxPrice,
                    divisions: (maxPrice / 1000).toInt(), // Divisions every 1000
                    values: RangeValues(lowPrice, highPrice),
                    activeColor: kPrimaryColor,
                    inactiveColor: kPrimaryColor.withOpacity(0.3),
                    labels: RangeLabels(
                      "₹${NumberFormat('#,###').format(lowPrice.toInt())}",
                      "₹${NumberFormat('#,###').format(highPrice.toInt())}",
                    ),
                    onChanged: (values) {
                      setState(() {
                        lowPrice = values.start;
                        highPrice = values.end;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- 6. Search Button ---
              ElevatedButton(
                onPressed: _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  '🔍 Search Hotels',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}