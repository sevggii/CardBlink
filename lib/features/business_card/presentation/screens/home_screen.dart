import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/business_card_provider.dart';
import '../widgets/business_card_tile.dart';
import 'card_detail_screen.dart';

/// Home Screen
/// Main screen showing list of scanned business cards
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _scanCard() async {
    try {
      // Pick image from camera or gallery
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      // Show loading
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Scan the card
      final card = await ref
          .read(businessCardNotifierProvider.notifier)
          .scanCard(image);

      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog

      if (card == null) {
        // Duplicate found
        _showDuplicateDialog();
      } else {
        // Show success and navigate to detail
        _showSuccessDialog(card.id!);
      }

      // Refresh the list
      ref.invalidate(filteredCardsProvider);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return;

      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final card = await ref
          .read(businessCardNotifierProvider.notifier)
          .scanCard(image);

      if (!mounted) return;
      Navigator.pop(context);

      if (card == null) {
        _showDuplicateDialog();
      } else {
        _showSuccessDialog(card.id!);
      }

      ref.invalidate(filteredCardsProvider);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _exportData() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Export as CSV'),
              onTap: () async {
                Navigator.pop(context);
                await _exportAsCSV();
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Export as Excel'),
              onTap: () async {
                Navigator.pop(context);
                await _exportAsExcel();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportAsCSV() async {
    try {
      final csvData = await ref
          .read(businessCardNotifierProvider.notifier)
          .exportToCSV();

      // For mobile: save and share
      // For web: download
      final file = XFile.fromData(
        Uint8List.fromList(csvData.codeUnits),
        mimeType: 'text/csv',
        name: AppConstants.exportFileNameCSV,
      );

      await Share.shareXFiles([file]);
    } catch (e) {
      _showErrorDialog('Export failed: ${e.toString()}');
    }
  }

  Future<void> _exportAsExcel() async {
    try {
      final excelData = await ref
          .read(businessCardNotifierProvider.notifier)
          .exportToExcel();

      final file = XFile.fromData(
        Uint8List.fromList(excelData),
        mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        name: AppConstants.exportFileNameExcel,
      );

      await Share.shareXFiles([file]);
    } catch (e) {
      _showErrorDialog('Export failed: ${e.toString()}');
    }
  }

  void _showDuplicateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, size: 48),
        title: const Text('Duplicate Card'),
        content: const Text(
          'This person is already registered in your contacts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String cardId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.check_circle,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('Success'),
        content: const Text('Business card scanned successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailScreen(cardId: cardId),
                ),
              );
            },
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error_outline, size: 48, color: Colors.red),
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(filteredCardsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            tooltip: 'Export',
            onPressed: _exportData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // Cards List
          Expanded(
            child: cardsAsync.when(
              data: (cards) {
                if (cards.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_rounded,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No business cards yet',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the camera button to scan your first card',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return BusinessCardTile(
                      card: card,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CardDetailScreen(cardId: card.id!),
                          ),
                        ).then((_) {
                          ref.invalidate(filteredCardsProvider);
                        });
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'gallery',
            onPressed: _pickFromGallery,
            tooltip: 'Pick from Gallery',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: 'camera',
            onPressed: _scanCard,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scan Card'),
          ),
        ],
      ),
    );
  }
}

