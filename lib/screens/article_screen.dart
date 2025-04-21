import 'package:flutter/material.dart';
import 'article.dart'; // Import ArticleService
import '/models/dream.dart'; // Import Dream model
import 'home_screen.dart'; // Import HomeScreen to access static dreams list

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});
  
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  // Add state variables to track which tab is selected
  int _selectedIndex = 1; // 0 for Dreams, 1 for Articles (default to Articles for this screen)
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        backgroundColor: const Color(0xFF011638), // Dark blue background
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: _buildArticleList(),
      // Bottom navigation bar similar to HomeScreen
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF1A1F37), // Same dark blue as HomeScreen
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomAppBar(
            height: 70,
            padding: EdgeInsets.zero,
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            color: const Color(0xFF1A1F37),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left button - View Card Dream
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Update selected index and navigate
                      setState(() {
                        _selectedIndex = 0; // Set Dreams as selected
                      });
                      Navigator.pushNamed(context, '/view-card-dream');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_stories,
                          // Change color based on selection state - white when not selected
                          color: _selectedIndex == 0 ? const Color(0xFF394FAA) : Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dreams',
                          style: TextStyle(
                            // Change text color based on selection state - same as icon
                            color: _selectedIndex == 0 ? const Color(0xFF394FAA) : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Spacer for FAB
                const Expanded(child: SizedBox()),
                
                // Right button - View Article (highlighted as active)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Update selected index (stay on current screen)
                      setState(() {
                        _selectedIndex = 1; // Set Articles as selected
                      });
                      // Already on article screen, no navigation needed
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          // Change color based on selection state - blue when selected (matches HomeScreen)
                          color: _selectedIndex == 1 ? const Color(0xFF394FAA) : Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Articles',
                          style: TextStyle(
                            // Change text color based on selection state - same as icon
                            color: _selectedIndex == 1 ? const Color(0xFF394FAA) : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Use the same color as in HomeScreen (0xFF394FAA)
          color: const Color(0xFF394FAA), // Changed from gradient to solid color to match HomeScreen
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3148A1).withOpacity(0.5), // Match HomeScreen shadow
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            // Navigate to add dream screen and wait for result
            final result = await Navigator.pushNamed(context, '/add-dream');
            
            // Update the HomeScreen's static dreams list if a new dream was added
            if (result != null && result is Dream) {
              setState(() {
                HomeScreen.dreams.add(result); // Add to HomeScreen's static list
              });
            }
          },
          backgroundColor: Colors.transparent, // Keep transparent to show container color
          elevation: 0,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildArticleList() {
    // Rest of the code remains the same
    return FutureBuilder<List<dynamic>>(
      future: ArticleService.fetchSleepArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No articles found'));
        }

        final articles = snapshot.data!;

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return _buildArticleCard(article);
          },
        );
      },
    );
  }

  Widget _buildArticleCard(dynamic article) {
    // Rest of the code remains the same
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color(0xFF0D2143),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Add any action when tapping on the article
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image
            if (article['urlToImage'] != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  article['urlToImage'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white.withOpacity(0.5),
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Article description
                  Text(
                    article['description'] ?? 'No description available',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          // Add share functionality
                        },
                      ),
                    ],
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