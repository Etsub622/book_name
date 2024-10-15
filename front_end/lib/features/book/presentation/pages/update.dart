import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/common_widget.dart/snack_bar.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/widget/custom_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:http/http.dart' as http;

class UpdatePage extends StatefulWidget {
  final String title;
  final String author;
  final String description;
  final num price;
  final List<String> imageUrl;
  final List<String> category;
  final Function(Map<String, Object>) onUpdate;

  const UpdatePage({
    super.key,
    required this.author,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.onUpdate,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController imageController;

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    authorController = TextEditingController(text: widget.author);
    descriptionController = TextEditingController(text: widget.description);
    priceController = TextEditingController(text: widget.price.toString());
    imageController = TextEditingController(
        text: widget.imageUrl.isNotEmpty ? widget.imageUrl[0] : '');
    selectedCategories = widget.category;
  }

  void UpdateBook() async {
    await _uploadImages(); 
    final Map<String, Object> updatedbook = {
      'title': titleController.text,
      'author': authorController.text,
      'description': descriptionController.text,
      'imageUrl': _imageUrls.isNotEmpty ? _imageUrls[0] : imageController.text,
      'price': num.parse(priceController.text),
      'category': selectedCategories,
    };
    widget.onUpdate(updatedbook); 
  }

  List<String> categoryOption = const [
    'adventure',
    'comedy',
    'drama',
    'fantasy',
    'crime',
    'psychology'
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookUpdated) {
          final snack = snackBar('book successfully Updated!');
          ScaffoldMessenger.of(context).showSnackBar(snack);
        } else if (state is BookError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('book update Failed!'),
            backgroundColor: Colors.red,
          ));
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Color.fromARGB(255, 19, 38, 247),
                        size: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 130,
                    ),
                    const Text(
                      'Update the book',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF3E3E3E),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text('Change image',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF3E3E3E),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: _imageFiles.isNotEmpty
                      ? Image.file(
                          _imageFiles[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.network(
                          imageController.text,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('title',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF3E3E3E),
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(controller: titleController),
                const SizedBox(
                  height: 10,
                ),
                const Text('author',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF3E3E3E),
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(controller: authorController),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('price',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF3E3E3E),
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: priceController,
                  sign: '\$',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('description',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF3E3E3E),
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Category',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF3E3E3E),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MultiSelectDialogField<String>(
                    items: categoryOption
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    initialValue: selectedCategories,
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
                      items: selectedCategories
                          .map((category) =>
                              MultiSelectItem<String>(category, category))
                          .toList(),
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
                  height: 15.h,
                ),
                InkWell(
                  onTap: UpdateBook,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0XFF3F51F3),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    height: 45,
                    child: const Center(
                        child: Text('Update',
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageController.dispose();

    super.dispose();
  }
}
