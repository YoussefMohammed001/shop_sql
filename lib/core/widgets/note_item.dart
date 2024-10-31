import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key,
      required this.id,
      required this.title,
      required this.inFavorite,
      required this.inArchive,
      required this.onFavTap,
      required this.onArchiveTap,
      this.favVisible = true,
        this.archiveVisible = true
      });
  final int id;
  final String title;
  final int inFavorite, inArchive;
  final VoidCallback onFavTap, onArchiveTap;
  final bool favVisible, archiveVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              id.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: favVisible,
                child: InkWell(
                  onTap: onFavTap,
                  child: Icon(
                    inFavorite == 1 ? Icons.favorite : Icons.favorite_border,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
                Visibility(
                  visible: archiveVisible,
                  child: InkWell(
                  onTap: onArchiveTap,
                  child: Icon(
                    inArchive == 1 ? Icons.archive : Icons.archive_outlined,
                    color: Colors.blueAccent,
                  ),
                                ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
