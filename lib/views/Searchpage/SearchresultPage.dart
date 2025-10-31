// search_results_page.dart
import 'package:flutter/material.dart'; // Import the service

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;
  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {

  List<dynamic> _hotels = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
   // _fetchResults();
  }

  // Future<void> _fetchResults() async {
  //   if (_isLoading) return;
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final result = await _hotelService.fetchHotels(
  //       query: widget.searchQuery,
  //       page: _currentPage,
  //     );
  //
  //     setState(() {
  //       // Assuming your API response structure is like:
  //       // { "results": [...], "pagination": { "totalPages": 5, "currentPage": 1 } }
  //       _hotels = result['results'];
  //       _totalPages = result['pagination']['totalPages'] as int;
  //     });
  //   } catch (e) {
  //     // Display error to the user (e.g., Snackbar)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error fetching results: ${e.toString()}')),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  //
  // void _changePage(int newPage) {
  //   if (newPage > 0 && newPage <= _totalPages && newPage != _currentPage) {
  //     setState(() {
  //       _currentPage = newPage;
  //     });
  //     // Scroll to the top when page changes (optional)
  //     _fetchResults();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for: "${widget.searchQuery}"'),
      ),
      body: Column(
        children: [
          if (_isLoading)
            const LinearProgressIndicator(),

          // List of Search Results
          Expanded(
            child: _hotels.isEmpty && !_isLoading
                ? Center(child: Text('No hotels found for "${widget.searchQuery}".'))
                : ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (context, index) {
                final hotel = _hotels[index];
                // Assuming the hotel object has 'name' and 'city' properties
                return ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(hotel['name'] ?? 'Hotel Name'),
                  subtitle: Text(hotel['city'] ?? 'City'),
                  onTap: () {
                    // Navigate to detail page
                  },
                );
              },
            ),
          ),

          // 📑 Pagination Controls
          _totalPages > 1
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed:(){},
                  //_currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
                ),
                Text('Page $_currentPage of $_totalPages'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed:(){},
                  //_currentPage < _totalPages ? () => _changePage(_currentPage + 1) : null,
                ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}