import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/shared/parts/layout_width_preset.dart';
import 'package:my_portfolio/shared/providers.dart';

class LayoutWidthDropdownButton extends ConsumerWidget {
  const LayoutWidthDropdownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPreset = ref.watch(layoutWidthPresetProvider);
    final labelStyle = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: Colors.yellow);

    return Center(
      child: Tooltip(
        message: 'Layout width',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<LayoutWidthPreset>(
              value: currentPreset,
              isDense: true,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: Colors.black87,
              iconEnabledColor: Colors.yellow,
              style: labelStyle,
              onChanged: (preset) {
                if (preset == null) {
                  return;
                }
                ref.read(layoutWidthPresetProvider.notifier).state = preset;
              },
              selectedItemBuilder: (context) => LayoutWidthPreset.values
                  .map(
                    (preset) => Align(
                      alignment: Alignment.center,
                      child: Text(preset.label, style: labelStyle),
                    ),
                  )
                  .toList(growable: false),
              items: LayoutWidthPreset.values
                  .map(
                    (preset) => DropdownMenuItem<LayoutWidthPreset>(
                      value: preset,
                      child: Text(preset.menuLabel, style: labelStyle),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      ),
    );
  }
}
