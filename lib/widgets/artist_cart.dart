import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/constants.dart';
import 'package:hear_me/models/artist.dart';
import 'package:hear_me/pages/artist_information_page.dart';

class ArtistCard extends StatefulWidget {
  const ArtistCard({
    Key? key,
    required this.size,
    required this.item,
  }) : super(key: key);

  final Size size;
  final Artist item;

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ArtistInformationPage.id, arguments: widget.item.id);
      },
      child: SizedBox(
        height: 90,
        child: Row(
          children: [
            CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage(widget.item.imageUrl),
            ),
            const SizedBox(width: 16),
            Text(
              widget.item.name,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            widget.item.isCertified
                ? Image.asset(
                    'assets/icons/quality.png',
                    width: 15,
                  )
                : Container(),
            const Spacer(),
            FollowButton(
                isFollowing: widget.item.isFollowing,
                onPressed: () {
                  setState(() {
                    widget.item.isFollowing = !widget.item.isFollowing;
                  });
                })
          ],
        ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final Function onPressed;
  const FollowButton({
    Key? key,
    this.isFollowing = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFollowing
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                side: const BorderSide(color: AppColors.primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () => onPressed(),
            child: Text('Following',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor)))
        : ElevatedButton(
            style: OutlinedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () => onPressed(),
            child: Text('Follow',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)));
  }
}
