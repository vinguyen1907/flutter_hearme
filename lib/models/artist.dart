// ignore_for_file: public_member_api_docs, sort_constructors_first
class Artist {
  String id;
  String name;
  bool isFollowing;
  String imageUrl;
  bool isCertified;
  bool isPopular;
  Artist({
    required this.id,
    required this.name,
    required this.isFollowing,
    required this.imageUrl,
    required this.isCertified,
    required this.isPopular,
  });

  static List<Artist> artistsList = [
    Artist(
        id: "1",
        name: 'Đen Vâu',
        isFollowing: false,
        imageUrl:
            'https://cafefcdn.com/thumb_w/650/203337114487263232/2020/11/3/photo1604375159521-16043751633361898292724.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "2",
        name: 'The Weeknd',
        isFollowing: false,
        imageUrl:
            'https://icdn.dantri.com.vn/thumb_w/660/2021/10/04/the-weekndeoline-1633335325012.jpeg',
        isCertified: true,
        isPopular: false),
    Artist(
        id: "3",
        name: 'Ariana Grande',
        isFollowing: false,
        imageUrl:
            'https://avatar-ex-swe.nixcdn.com/singer/avatar/2020/10/28/6/b/8/9/1603867029190_600.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "4",
        name: 'Katy Perry',
        isFollowing: true,
        imageUrl:
            'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/5/3/904929/Ca-Si-Katy-Perry.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "5",
        name: 'Ryan Jones',
        isFollowing: false,
        imageUrl: 'https://f4.bcbits.com/img/a0181208041_2.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "6",
        name: 'Acidrap',
        isFollowing: true,
        imageUrl:
            'https://i.scdn.co/image/ab67616d0000b273d95ab48a8a9de3c4a2cbfe80',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "7",
        name: 'Clean Bandit',
        isFollowing: false,
        imageUrl:
            'https://billboardvn.vn/wp-content/uploads/2019/02/Clean-Bandit-press-photo-cr-Rita-Zimmermann-a-2017-billboard-1548-e1551149534596.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "8",
        name: 'Camila Cabello',
        isFollowing: true,
        imageUrl:
            'https://congluan-cdn.congluan.vn/files/content/2022/06/18/camila-cabello-sau-scandal-o-champions-league-dang-say-trong-men-tinh-083906473.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "9",
        name: 'Alan Walker',
        isFollowing: false,
        imageUrl:
            'https://zmp3-photo-fbcrawler.zmdcdn.me/avatars/2/c/1/3/2c139949903f4a0cdbc39bb988be596e.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "10",
        name: 'Maroon 5',
        isFollowing: false,
        imageUrl:
            'https://www.arthipo.com/image/cache/catalog/poster/music/music129-maroon-5-poster-singer-sarkici-sanatci-afis-muzik-500x500h.jpg',
        isCertified: true,
        isPopular: true),
    Artist(
        id: "11",
        name: 'Justin Bieber',
        isFollowing: false,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Justin_Bieber_in_2015.jpg/250px-Justin_Bieber_in_2015.jpg',
        isCertified: true,
        isPopular: true),
  ];
}
