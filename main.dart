import 'package:flutter/material.dart';

void main() => runApp(const JobFinder());

class JobFinder extends StatelessWidget {
  const JobFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final search = TextEditingController();
  String category = 'All';

  final jobs = [
    ['Flutter Developer', 'Google', 'Hyderabad', '₹25K/month', 'Internship'],
    ['Software Engineer', 'Microsoft', 'Bangalore', '₹8 LPA', 'Full Time'],
    ['UI/UX Designer', 'Adobe', 'Mumbai', '₹35K/month', 'Internship'],
    ['Data Analyst', 'Amazon', 'Chennai', '₹6 LPA', 'Full Time'],
    ['Web Developer', 'Infosys', 'Pune', '₹30K/month', 'Internship'],
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = jobs.where((job) {
      final q = search.text.toLowerCase();
      return (category == 'All' || job[4] == category) &&
          (job[0].toLowerCase().contains(q) ||
              job[1].toLowerCase().contains(q));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job & Internship Finder',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search jobs or companies...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['All', 'Internship', 'Full Time'].map((c) {
                return ChoiceChip(
                  label: Text(c),
                  selected: category == c,
                  onSelected: (_) => setState(() => category = c),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('No jobs found'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final job = filtered[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      child: Text(job[1][0],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(job[0],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text('${job[1]} • ${job[2]}'),
                                Text('${job[3]} • ${job[4]}'),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Application'),
                                        content: Text(
                                            'You applied for ${job[0]} at ${job[1]}.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          )
                                        ],
                                      ),
                                    ),
                                    child: const Text('Apply Now'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
