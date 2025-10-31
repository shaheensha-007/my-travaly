import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import 'package:metechology/getx_controller/Simplehostal_getx_controller/simplehostal_getx.dart';
import '../../Contollers/SignoutController/SignoutController.dart';
import '../Searchpage/HotelSearchScreen.dart';
import '../../core/Api/Api_Servies.dart';
import '../../core/Repository/Register_Api/RegisterApi.dart';
import '../../core/Repository/SimpleHostal_Api/Simplehostal_Api.dart';
import '../../getx_controller/Registration_getx_contoller/RegstionController.dart';
import '../Searchpage/SearchresultPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final appUser = FirebaseAuth.instance.currentUser;

  final signOutController = SiginoutController();
  final registrationController = Get.put(RegistrationController(RegistrationRepository(ApiService())));
  final simplehostalController = Get.put(SimplehotelGetx(SimplehostalRepository(ApiService())));

  final TextEditingController _searchController = TextEditingController();

  // void _performSearch(String query) {
  //   if (query.trim().isNotEmpty) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SearchResultsPage(searchQuery: query),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (registrationController.registrationData.value == null) {
        registrationController.registerDevice();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Centers the title for better symmetry
        // title: const Text(
        //   'Home',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //     letterSpacing: 0.5,
        //   ),
        // ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black87,
              size: 26,
            ),
            tooltip: 'Sign Out', // Accessibility + UX improvement
            splashRadius: 24,
            onPressed: () {
              signOutController.signOutUser();
            },
          ),
          const SizedBox(width: 8),

        // Optional padding at the end
        ],
        // Optional: Add subtle bottom border or shadow if needed
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(1),
        //   child: Container(
        //     color: Colors.grey.shade300,
        //     height: 1,
        //   ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          NavigationService.push(HotelSearchScreen());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.search, color: Colors.white, size: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
      ),
      body: Obx(() {
      // Loading
      if (registrationController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Error
      if (registrationController.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text(
            "Error: ${registrationController.errorMessage.value}",
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

       // Success
      return _buildHomeBody(registrationController.visitorToken);

      }),
    );
  }

  //  Extracted body widget
  Widget _buildHomeBody(String token) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User info
        if (appUser != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "👋 Welcome, ${appUser!.displayName?? 'User'}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
        const SizedBox(height: 16),
        // Search Bar
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: TextField(
        //     controller: _searchController,
        //     decoration: InputDecoration(
        //       hintText: 'Search hotels, city, or country...',
        //       prefixIcon: const Icon(Icons.search),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(30.0),
        //         borderSide: BorderSide.none,
        //       ),
        //       filled: true,
        //       fillColor: Colors.grey[200],
        //       suffixIcon: IconButton(
        //         icon: const Icon(Icons.clear),
        //         onPressed: () => _searchController.clear(),
        //       ),
        //     ),
        //     onSubmitted: _performSearch,
        //   ),
        // ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Sample Hotels:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // 🏨 Hotel list
        Expanded(
          child: Obx(() {
            if (simplehostalController.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Searching hotels...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (simplehostalController.errorMessage.isNotEmpty) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
                      const SizedBox(height: 12),
                      Text(
                        'Oops! Something went wrong',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        simplehostalController.errorMessage.value,
                        style: TextStyle(color: Colors.red.shade600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }


    final model = simplehostalController.simplehostaldata.value;

    if (model == null ||
    model.data == null ||
    model.data!.autoCompleteList == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search criteria',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }
    final autoComplete = model.data!.autoCompleteList!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Hotels Section
                if (autoComplete.byPropertyName?.listOfResult != null &&
                    autoComplete.byPropertyName!.listOfResult!.isNotEmpty) ...[
                  _buildSectionHeader(
                    'Hotels',
                    autoComplete.byPropertyName!.numberOfResult ?? 0,
                    Icons.hotel_rounded,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  ...autoComplete.byPropertyName!.listOfResult!.map((hotel) =>
                      _buildHotelCard(hotel)
                  ),
                  const SizedBox(height: 24),
                ],

                // Cities Section
                if (autoComplete.byCity?.listOfResult != null &&
                    autoComplete.byCity!.listOfResult!.isNotEmpty) ...[
                  _buildSectionHeader(
                    'Cities',
                    autoComplete.byCity!.numberOfResult ?? 0,
                    Icons.location_city_rounded,
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  ...autoComplete.byCity!.listOfResult!.map((city) =>
                      _buildCityCard(city)
                  ),
                  const SizedBox(height: 24),
                ],

                // Streets Section
                if (autoComplete.byStreet?.listOfResult != null &&
                    autoComplete.byStreet!.listOfResult!.isNotEmpty) ...[
                  _buildSectionHeader(
                    'Locations',
                    autoComplete.byStreet!.numberOfResult ?? 0,
                    Icons.place_rounded,
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  ...autoComplete.byStreet!.listOfResult!.map((street) =>
                      _buildStreetCard(street)
                  ),
                  const SizedBox(height: 24),
                ],

                // Country Section
                if (autoComplete.byCountry?.listOfResult != null &&
                    autoComplete.byCountry!.listOfResult!.isNotEmpty) ...[
                  _buildSectionHeader(
                    'Countries',
                    autoComplete.byCountry!.numberOfResult ?? 0,
                    Icons.public_rounded,
                    Colors.purple,
                  ),
                  const SizedBox(height: 12),
                  ...autoComplete.byCountry!.listOfResult!.map((country) =>
                      _buildCountryCard(country)
                  ),
                ],
              ],
            );
          }
          ),
        ),
      ],
    );
  }
  Widget _buildSectionHeader(String title, int count, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

// Hotel Card Widget
  Widget _buildHotelCard(dynamic hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to hotel details
            print('Hotel ID: ${hotel.searchArray?.query?.first}');
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.propertyName ?? 'Unknown Hotel',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${hotel.address?.city ?? ''}, ${hotel.address?.state ?? ''}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// City Card Widget
  Widget _buildCityCard(dynamic city) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to city search
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.orange.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.location_city_rounded,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city.address?.city ?? 'Unknown City',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${city.address?.state ?? ''}, ${city.address?.country ?? ''}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Street Card Widget
  Widget _buildStreetCard(dynamic street) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to location
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.place_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        street.address?.street ?? 'Unknown Location',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3142),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${street.address?.city ?? ''}, ${street.address?.state ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Country Card Widget
  Widget _buildCountryCard(dynamic country) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to country search
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade400, Colors.purple.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                      Icons.public_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    country.address?.country ?? 'Unknown Country',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
