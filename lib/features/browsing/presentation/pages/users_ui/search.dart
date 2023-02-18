import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  @override
  void initState() {
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  dispose() {
    if (mounted) {
      _searchController.dispose();
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        // size: 24,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      // style: const TextStyle(color: AppColors.primaryColor),
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                          hintText: 'Rechercher',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(bottom: 3),
                          // fillColor: AppColors.cardColor,
                          // filled: true,
                          suffix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _focusNode.unfocus();
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  runSpacing: 0,
                  spacing: 4,
                  children: [
                    Chip(
                      backgroundColor: AppColors.backgroundColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      label: const Text('Cuisse de poulet'),
                    ),
                    Chip(
                      backgroundColor: AppColors.backgroundColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      label: const Text('Poulet entier'),
                    ),
                    Chip(
                      backgroundColor: AppColors.backgroundColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      label: const Text('Poulet sur pattes'),
                    ),
                    Chip(
                      backgroundColor: AppColors.backgroundColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      label: const Text('Caille'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
