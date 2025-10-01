import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/language_provider/language_provider.dart';
import 'package:flutter_murcia_2_oct/l10n/L10N.dart';
import 'package:provider/provider.dart';

class LanguageDropdown extends StatefulWidget {
  final bool simpleMode;
  const LanguageDropdown({this.simpleMode = false, super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.2),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      child: DropdownButton<Locale>(
        value: context.read<LanguageProvider>().locale,
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(8),
        items:
            L10n.all.map((loc) {
              final label = L10n.getFlag(code: loc.languageCode, size: 20);
              return DropdownMenuItem(
                value: loc,
                child:
                    widget.simpleMode
                        ? label
                        : Row(
                          children: [
                            label,
                            SizedBox(width: 10),
                            Text(L10n.getLanguageName(loc.languageCode)),
                          ],
                        ),
              );
            }).toList(),
        onChanged: (Locale? newLoc) {
          if (newLoc == null) return;
          context.read<LanguageProvider>().setLanguage(newLoc);
        },
      ),
    );
  }
}
