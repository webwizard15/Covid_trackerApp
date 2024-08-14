import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statsServicesApi = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search with country's name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: statsServicesApi.countriesListApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 8, // Simulating 8 items for the shimmer effect
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),
                            title: Container(
                              width: double.infinity,
                              height: 16.0,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              width: double.infinity,
                              height: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    // Filter the countries based on the search text
                    List<dynamic> filteredCountries = snapshot.data!.where((country) {
                      String name = country["country"];
                      return name.toLowerCase().contains(searchController.text.toLowerCase().trim());
                    }).toList();

                    if (filteredCountries.isEmpty) {
                      return const Center(child: Text('No country found'));
                    }

                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        var country = filteredCountries[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: country["country"],
                                      image: country["countryInfo"]["flag"], // Correctly accessing the image URL
                                      active: country["active"],
                                      critical: country["critical"],
                                      test: country["tests"],
                                      totalCases: country["cases"],
                                      totalDeaths: country["deaths"],
                                      totalRecovered: country["recovered"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Image.network(
                                  country["countryInfo"]["flag"], // Correctly accessing the image URL
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(country["country"]),
                                subtitle: Text('Cases: ${country["cases"]}'),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
