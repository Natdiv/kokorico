import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/const.dart';
import 'package:kokorico/core/helpers/locator.dart';
import 'package:kokorico/core/helpers/routes.dart';
import 'package:kokorico/core/helpers/utility.dart';
import 'package:kokorico/features/browsing/domain/usescases/create_product.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/loading_page.dart';
import 'package:kokorico/features/browsing/presentation/state/app_state.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/colors.dart';
import '../../../data/models/product_model.dart';
import '../common/widgets/custom_button.dart';
import '../common/widgets/success_or_failure.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  CreateProduct createProduct = getIt<CreateProduct>();

  final formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;

  String? imageSrc;

  // FilePickerResult? result;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'png', 'jpeg'],
      type: FileType.custom,
    );
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  Future uploadFile() async {
    try {
      final directory = pickedFile!.name.split('.').isNotEmpty
          ? pickedFile!.name.split('.')[0]
          : '';
      final path = 'products/$directory/${pickedFile!.name}';

      final file = File(pickedFile!.path!);

      final ref = _firebaseStorage.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      imageSrc = await snapshot.ref.getDownloadURL();
      print('Download Link: $imageSrc');
      setState(() {
        uploadTask = null;
      });
    } on FirebaseException catch (e) {
      print('UPLOAD ERROR: ${e.message}');
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _unitController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<AppState>(context, listen: false);
    // if (!state.isbusy) {
    //   return _mainBody(context);
    // }
    // return const LoadingScreen();
    return _mainBody(context);
  }

  Widget _mainBody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Text('Ajouter un produit',
          //     style: GoogleFonts.poppins(
          //         textStyle: const TextStyle(
          //             color: AppColors.primaryColorDark,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold))),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.primaryColorDark,
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Nouveau produit',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: AppColors.primaryColorDark,
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez saisir le nom du produit';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Nom du produit',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    maxLength: 128,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez saisir une courte description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez saisir le prix de l\'article';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Le prix de l\'aricle',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _unitController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez saisir l\'unité de mesure';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Unité de mesure (Ex. Kg)',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  verticalSpacer(height: 12),
                  if (pickedFile != null)
                    Container(
                      height: 150,
                      width: 159,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 5,
                              color: AppColors.cardColor,
                              style: BorderStyle.solid)),
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.file(
                          File(pickedFile!.path!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildProgress(),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: 'Choisir l\'image',
                    backgroundColor: Colors.white,
                    textColor: AppColors.primaryColorDark,
                    onTap: () async {
                      selectFile();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: 'Enregistrer',
                    backgroundColor: AppColors.primaryColorDark,
                    textColor: Colors.white,
                    onTap: () {
                      print('picked file: $pickedFile');
                      if (formKey.currentState!.validate() &&
                          pickedFile != null) {
                        _createProduct();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        )));
  }

  StreamBuilder<TaskSnapshot> _buildProgress() {
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.secondaryColor.withOpacity(0.10),
                color: AppColors.secondaryColor,
              ),
            );
          }
          return Container();
        });
  }

  void _createProduct() async {
    // final state = Provider.of<AppState>(context, listen: false);
    // state.isBusy = true;

    await uploadFile();

    final product = ProductModel(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: imageSrc!,
      price: double.parse(_priceController.text.trim()),
      unit: _unitController.text.trim(),
    );

    // print(product);

    (await createProduct(product)).fold((failure) {
      // state.isBusy = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Echec de l\'enregistrement'));
    }, (success) {
      // state.isBusy = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Enregistrement réussi'));

      Timer(const Duration(milliseconds: 5000), () {
        Routes.pushReplacement(context, '/all-products');
        formKey.currentState!.reset();
      });
    });
  }
}
