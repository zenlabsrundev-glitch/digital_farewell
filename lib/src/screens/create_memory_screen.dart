import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/seeded_art.dart';

class CreateMemoryScreen extends StatefulWidget {
  const CreateMemoryScreen({super.key});

  @override
  State<CreateMemoryScreen> createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends State<CreateMemoryScreen> {
  final _textController = TextEditingController();
  final _titleController = TextEditingController();

  int? _imageSeed;

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Create Memory', style: textTheme.titleLarge),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Capture a moment', style: textTheme.headlineSmall)
                  .animate()
                  .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.08, end: 0, duration: 420.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 14),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassTextField(
                        label: 'Title',
                        controller: _titleController,
                        hintText: 'Give it a name',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      GlassTextField(
                        label: 'Memory',
                        controller: _textController,
                        hintText: 'Write what you want to keep…',
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: 12),
                      GlassContainer(
                        radius: 28,
                        opacity: isDark ? 0.16 : 0.10,
                        borderOpacity: 0.18,
                        blurSigma: 18,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Optional image', style: textTheme.titleMedium),
                                const Spacer(),
                                Icon(
                                  Icons.photo_library_outlined,
                                  color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.78),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (_imageSeed != null)
                              SeededImageCard(seed: _imageSeed!, height: 190, radius: 22)
                            else
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.16),
                                  ),
                                  color: Colors.white.withValues(alpha: 0.05),
                                ),
                                child: Center(
                                  child: Text(
                                    'Tap to attach (mock)',
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            PrimaryButton(
                              label: _imageSeed == null ? 'Add image' : 'Change image',
                              icon: Icons.add_photo_alternate_outlined,
                              onPressed: () {
                                setState(() {
                                  _imageSeed = DateTime.now().millisecondsSinceEpoch % 300;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Post memory',
                      icon: Icons.send_rounded,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 120.ms, duration: 420.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.10, end: 0, delay: 120.ms, duration: 420.ms, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}

