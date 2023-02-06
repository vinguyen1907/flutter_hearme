// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hear_me/constants/app_color.dart';

class ExploreItem {
  String id;
  String name;
  Color color;
  String imageUrl;
  ExploreItem({
    required this.id,
    required this.name,
    required this.color,
    required this.imageUrl,
  });

  static List<ExploreItem> itemsList = [
    ExploreItem(
        id: '1',
        name: 'Charts',
        color: AppColors.primaryColor,
        imageUrl:
            'https://icdn.dantri.com.vn/thumb_w/660/2021/10/04/the-weekndeoline-1633335325012.jpeg'),
    ExploreItem(
        id: '2',
        name: 'Podcasts',
        color: const Color(0xFFA634FF),
        imageUrl:
            'https://cdn-images-1.listennotes.com/podcasts/the-jordan-harbinger-show-jordan-harbinger-fxpBnz4I_2F-hjYQbpFH5vB.1400x1400.jpg'),
    ExploreItem(
        id: '3',
        name: 'New Releases',
        color: Color(0xFFFBD74A),
        imageUrl:
            'https://cdnmedia.thethaovanhoa.vn/Upload/PQgc44ci4D5b7WtAo06jg/files/2022/08/1(27).jpg'),
    ExploreItem(
        id: '4',
        name: 'Only You',
        color: const Color(0xFF4970FA),
        imageUrl:
            'https://symbols.vn/wp-content/uploads/2022/02/Hinh-BTS-Butter-cute-dang-yeu.jpg'),
    ExploreItem(
        id: '5',
        name: 'Pop',
        color: const Color(0xFFFA6D80),
        imageUrl: 'https://i.ytimg.com/vi/0CWUFzbXVJg/mqdefault.jpg'),
    ExploreItem(
        id: '6',
        name: 'K-Pop',
        color: const Color(0xFFFC9F1D),
        imageUrl:
            'https://static2.yan.vn/YanNews/2167221/201811/nhung-lan-jisoo-rose-va-lisa-tro-thanh-vu-cong-cua-jennie-284673ea.jpg'),
    ExploreItem(
        id: '7',
        name: 'Rock',
        color: const Color(0xFF009588),
        imageUrl:
            'https://461in33ouydj16d6636fl8u1-wpengine.netdna-ssl.com/wp-content/uploads/2020/02/Paramount_Rock-of-Ages_A746682_web_credit-Liz-Lauren.jpg'),
    ExploreItem(
        id: '8',
        name: 'Hip-Hop',
        color: const Color(0xFF795449),
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/d/d7/Thai_Breakdancers.jpg'),
    ExploreItem(
        id: '9',
        name: 'Jazz',
        color: const Color(0xFF5F7D89),
        imageUrl:
            'https://s3-ap-southeast-1.amazonaws.com/images.spiderum.com/sp-images/4df8682042e511e99eacb3a642f191c8.png'),
    ExploreItem(
        id: '10',
        name: 'Romance',
        color: const Color(0xFF00BBD1),
        imageUrl: 'https://i.ytimg.com/vi/SsJ3PLPpVvg/maxresdefault.jpg'),
  ];
}
