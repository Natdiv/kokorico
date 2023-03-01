import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/const.dart';
import 'package:kokorico/core/helpers/locator.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';
import 'package:kokorico/features/browsing/domain/usescases/create_product.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/loading_page.dart';
import 'package:kokorico/features/browsing/presentation/state/app_state.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/colors.dart';
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

  bool finish = false;
  bool? successOrFailure;
  String? message;
  String? textButton;
  Function()? onTap;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'png', 'jpeg'],
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
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);
    if (!state.isbusy) {
      if (finish) {
        return SuccessOrFailureWidget(
          message: message!,
          textButton: textButton!,
          successOrFailure: successOrFailure!,
          onTap: onTap!,
        );
      }
      return _mainBody(context);
    }
    return const LoadingScreen();
  }

  Widget _mainBody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ajouter un produit',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.primaryColorDark,
              icon: const Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
                onPressed: () {},
                color: AppColors.primaryColorDark,
                icon: const Icon(Icons.menu_outlined)),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            _buildProgress(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 42,
                      ),
                      Text(
                        'Nouveau produit',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: AppColors.primaryColorDark,
                                fontSize: 32,
                                fontWeight: FontWeight.w500)),
                      ),
                      // Text(
                      //   'Entrez les infor',
                      //   style: GoogleFonts.poppins(
                      //       textStyle: TextStyle(
                      //           color: AppColors.primaryColorDark.withOpacity(0.80),
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400)),
                      // ),
                      const SizedBox(
                        height: 36,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 2,
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
                      SizedBox(
                        height: 50,
                        child: TextFormField(
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
                      ),
                      verticalSpacer(height: 12),
                      if (pickedFile != null)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.primaryColor,
                                  style: BorderStyle.solid)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.file(
                              File(pickedFile!.path!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                      CustomButton(
                        text: 'Choisir l\'image',
                        backgroundColor: AppColors.primaryColorDark,
                        textColor: Colors.white,
                        onTap: () async {},
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate() &&
                                  imageSrc!.isNotEmpty) {
                                _createProduct();
                              }
                            },
                            child: Center(
                              child: Text(
                                'Enregistrer',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  Widget _buildProgress() {
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 5,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.secondaryColor.withOpacity(0.25),
                color: AppColors.secondaryColor,
              ),
            );
          }
          return Container();
        });
  }

  void _createProduct() async {
    final state = Provider.of<AppState>(context, listen: false);
    state.isBusy = true;

    final product = Product(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: imageSrc!,
      price: double.parse(_priceController.text.trim()),
      unit: _unitController.text.trim(),
    );

    (await createProduct(product)).fold((failure) {
      state.isBusy = false;
      setState(() {
        finish = true;
        message = 'Une erreur est survenue: ${failure.props.first}';
        textButton = 'Réessayer';
        successOrFailure = false;
        onTap = () {
          finish = false;
        };
      });
    }, (success) {
      state.isBusy = false;
      setState(() {
        finish = true;
        message = 'Produit enregistré avec succès';
        textButton = 'Retour';
        successOrFailure = true;
        onTap = () {
          Navigator.pop(context);
        };
      });
    });
  }
}
