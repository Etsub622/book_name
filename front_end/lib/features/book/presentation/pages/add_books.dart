import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/common_widget.dart/snack_bar.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/book/data/model/book_model.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:front_end/features/onboarding/presentation/widget/form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class AddBooksPages extends StatefulWidget {
  const AddBooksPages({super.key});

  @override
  State<AddBooksPages> createState() => _AddBooksPagesState();
}

class _AddBooksPagesState extends State<AddBooksPages> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  List<String> selectedCategories = [];

  void _addBook(BuildContext context) async {
    final newBook = BookModel(
        id: '',
        title: titleController.text,
        author: authorController.text,
        description: descriptionController.text,
        imageUrl: _imageUrls,
        category: selectedCategories,
        price: double.parse(priceController.text));

    context.read<BookBloc>().add(AddBookEvent(bookEntity: newBook));
  }

  // Pick images from the device
  List<File> _imageFiles = [];
  final List<String> _imageUrls = [];

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      }
    });
  }

// image uploading to cloudinary
  Future<void> _uploadImages() async {
    for (var imageFile in _imageFiles) {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dzfbycabj/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'imagePreset'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = json.decode(responseString);
        final url = jsonMap['url'];
        _imageUrls.add(url);
      } else {
        print('Failed to upload image');
      }
    }
  }

  List<String> categoryOption = const [
    'adventure',
    'comedy',
    'drama',
    'fantasy',
    'crime',
    'psychology'
  ];

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookAdded) {
          final snack = snackBar('book added successfully');
          ScaffoldMessenger.of(context).showSnackBar(snack);

          Future.delayed(const Duration(seconds: 2), () {
            context.go(AppPath.navbar);
          });
        } else if (state is BookError) {
          final snack = errorsnackBar('Book is not added, try again');
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }
      },
      builder: (context, state) {
        if (state is BookLoading) {
          return const CircularIndicator();
        } else {
          return _buildForm(context);
        }
      },
    ));
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Center(
              child: Text('Add Books',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (Color(0xff800080)),
                  )),
            ),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('title'),
                SizedBox(
                  height: 7.h,
                ),
                CustomFormField(text: 'title', controller: titleController),
                SizedBox(
                  height: 15.h,
                ),
                const Text('author'),
                SizedBox(
                  height: 7.h,
                ),
                CustomFormField(text: 'author', controller: authorController),
                SizedBox(
                  height: 15.h,
                ),
                const Text('description'),
                SizedBox(
                  height: 7.h,
                ),
                CustomFormField(
                    maxlines: 5,
                    text: 'description',
                    controller: descriptionController),
                SizedBox(
                  height: 15.h,
                ),
                const Text('price'),
                SizedBox(
                  height: 7.h,
                ),
                CustomFormField(text: 'price', controller: priceController),
                SizedBox(
                  height: 20.h,
                ),
                const Text('Category'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MultiSelectDialogField<String>(
                    items: categoryOption
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 215, 214, 214),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    buttonText: const Text('Book Category'),
                    title: const Text('Book Category'),
                    selectedColor: Colors.blue,
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    onConfirm: (List<String> values) {
                      setState(() {
                        selectedCategories = values;
                      });
                    },
                    chipDisplay: MultiSelectChipDisplay<String>(
                      onTap: (value) {
                        setState(() {
                          selectedCategories.remove(value);
                        });
                      },
                      textStyle: const TextStyle(color: Colors.black),
                      chipColor: Colors.white,
                    ),
                    searchable: true,
                    searchHint: 'Search here...',
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Text('select images'),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.add_a_photo,
                        size: 33,
                        color: Color(0xff800080),
                      ),
                    )),
                SizedBox(
                  height: 25.h,
                ),
                CustomButton(
                    wdth: double.infinity,
                    text: 'Add Book',
                    onTap: () async {
                      await _uploadImages();
                      _addBook(context);
                    }),
              ],
            ),
          ),
        ));
  }
}
