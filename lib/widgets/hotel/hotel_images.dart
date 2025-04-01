import 'package:flutter/material.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelImages extends StatefulWidget {
  final List<String> images;

  const HotelImages({required this.images, super.key});

  @override
  State<HotelImages> createState() => _HotelImagesState();
}

class _HotelImagesState extends State<HotelImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sublistedImages =
        widget.images.length > 6 ? widget.images.sublist(0, 6) : widget.images;

    return Column(
      spacing: 4,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            key: ValueKey<int>(_currentIndex),
            image: '${Constants.baseUrl}/${widget.images[_currentIndex]}',
            fit: BoxFit.cover,
            height: 260,
            width: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          height: 60,
          child: Row(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < sublistedImages.length; i++)
                Expanded(
                  child: i != 5
                      ? GestureDetector(
                          onTap: () => setState(() => _currentIndex = i),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 700),
                            opacity: _currentIndex == i ? 1 : 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                fit: BoxFit.cover,
                                image:
                                    '${Constants.baseUrl}/${sublistedImages[i]}',
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // TODO: Show all images
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  fit: BoxFit.cover,
                                  image:
                                      '${Constants.baseUrl}/${sublistedImages[i]}',
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  color: Color.fromRGBO(0, 15, 14, 0.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: MyText(
                                  '${widget.images.length - sublistedImages.length}+',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
