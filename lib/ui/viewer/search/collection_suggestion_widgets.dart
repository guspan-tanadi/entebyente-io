import 'package:flutter/material.dart';
import 'package:photos/db/files_db.dart';
import 'package:photos/ente_theme_data.dart';
import 'package:photos/models/collection_items.dart';
import 'package:photos/ui/viewer/file/thumbnail_widget.dart';
import 'package:photos/ui/viewer/gallery/collection_page.dart';
import 'package:photos/utils/navigation_util.dart';

class CollectionSuggestionWidgets {
  final List<CollectionWithThumbnail> matchedCollections;
  final BuildContext context;
  CollectionSuggestionWidgets(this.matchedCollections, this.context);
  List<Widget> generateSuggestionWidgets() {
    List<Widget> collectionSuggestionWidgets = [];

    for (CollectionWithThumbnail collectionWithThumbnail
        in matchedCollections) {
      collectionSuggestionWidgets.add(
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Album',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      collectionWithThumbnail.collection.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    FutureBuilder<int>(
                      future: FilesDB.instance.collectionFileCount(
                        collectionWithThumbnail.collection.id,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data > 0) {
                          int noOfMemories = snapshot.data;

                          return RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .defaultTextColor,
                              ),
                              children: [
                                TextSpan(text: noOfMemories.toString()),
                                TextSpan(
                                  text: noOfMemories != 1
                                      ? ' memories'
                                      : ' memory',
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ThumbnailWidget(collectionWithThumbnail.thumbnail),
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            routeToPage(context, CollectionPage(collectionWithThumbnail));
          },
        ),
      );
    }
    return collectionSuggestionWidgets;
  }
}
