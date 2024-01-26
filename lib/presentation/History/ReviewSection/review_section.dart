import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:provider/provider.dart';

import '../../../provider/account_session_provider.dart';

class ReviewSection extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final BookingInfo info;
  ReviewSection(
      {super.key,
      required this.info,
      required this.startTime,
      required this.endTime});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

Widget Review(List<TutorFeedback> items, BuildContext context) {
  return Container(
      height: 50,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[index].content!,
                
                ),
                RatingBar.builder(
                  initialRating: items[index].rating?.toDouble() ?? 0,
                  minRating: 0,
                  maxRating: 5,
                  allowHalfRating: false,
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (double value) {},
                ),
              ],
            );
          }));
}

class _ReviewSectionState extends State<ReviewSection> {
  String review = '';
  int stars = 0;
  String report = '';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime endTime = widget.endTime;
    DateTime startTime = widget.startTime;
    TextEditingController controller = TextEditingController();
    TextEditingController controller1 = TextEditingController();
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${languageProvider.language.lesson_time}: ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {},
                  child: Text(
                    languageProvider.language.record,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          Text(
            languageProvider.language.review_from_session,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.all(10),
          
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.info.feedbacks!.isNotEmpty
                    ? Review(widget.info.feedbacks!, context)
                    : Center(child: Text(languageProvider.language.no_review))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Review'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 72,
                                      height: 72,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: provider.user.avatar ?? '',
                                        fit: BoxFit.cover,
                                        errorWidget:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.user.name!,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(provider.user.email!)
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 0,
                                    maxRating: 5,
                                    allowHalfRating: false,
                                    direction: Axis.horizontal,
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        stars = rating.toInt();
                                        print(stars);
                                      });
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 3,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        hintText: 'Review',
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    review = controller.text;
                                    TutorFeedback feedback = TutorFeedback(
                                        content: review, rating: stars);
                                    widget.info.feedbacks?.add(feedback);
                                  });
                                  print(review);
                                  await TutorService.WriteFeedback(
                                      review,
                                      widget.info.id!,
                                      provider.user.id!,
                                      stars,
                                      accessToken);
                                  Navigator.pop(context);
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(languageProvider.language.add_review,
                      style: TextStyle(color: Colors.blue))),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(languageProvider.language.report),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: provider.user.avatar ?? '',
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.user.name!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(provider.user.email!)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 80,
                                child: TextField(
                                  controller: controller1,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      hintText:
                                          languageProvider.language.report,
                                      contentPadding: const EdgeInsets.all(12),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  report = controller1.text;
                                });
                                await TutorService.reportTutor(
                                    accessToken, provider.user.id!, report);
                                Navigator.pop(context);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                  languageProvider.language.report,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
