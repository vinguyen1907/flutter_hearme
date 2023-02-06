// ignore_for_file: public_member_api_docs, sort_constructors_first
class Song {
  String id;
  String name;
  String artistId;
  String imageUrl;
  String soundUrl;
  bool isTrending;
  Song({
    required this.id,
    required this.name,
    required this.artistId,
    required this.imageUrl,
    required this.soundUrl,
    required this.isTrending,
  });

  Song.from(Song a)
      : this(
          id: a.id,
          name: a.name,
          artistId: a.artistId,
          imageUrl: a.imageUrl,
          soundUrl: a.soundUrl,
          isTrending: a.isTrending,
        );

  static List<Song> songsList = [
    Song(
      id: '1',
      name: 'Havana',
      artistId: '7',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000399157941-z2r9pp-t500x500.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Camila%20Cabello%20-%20Havana%20ft.%20Young%20Thug.mp3?alt=media&token=0d49f35e-85cd-4e1f-9e98-082dd3dc11be',
      isTrending: true,
    ),
    Song(
      id: '2',
      name: 'All Falls Down',
      artistId: '8',
      imageUrl:
          'https://avatar-ex-swe.nixcdn.com/song/2017/11/29/0/6/1/1/1511969436155_640.jpg',
      soundUrl: '',
      isTrending: false,
    ),
    Song(
      id: '3',
      name: 'Sugar',
      artistId: '9',
      imageUrl:
          'https://file.tinnhac.com/resize/600x-/music/2017/05/16/b3c7049f44a4f291a27d-2acf.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Maroon%205%20%20Sugar.mp3?alt=media&token=9ce9e289-4cac-4ab3-932a-f7f0050b7b87',
      isTrending: true,
    ),
    Song(
      id: '4',
      name: 'Faded',
      artistId: '8',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000172159575-amqr49-t500x500.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Alan%20Walker%20%20Faded.mp3?alt=media&token=fd1423d6-218f-4b37-babf-5a7c612f9cbc',
      isTrending: true,
    ),
    Song(
      id: '5',
      name: 'Love Yourself',
      artistId: '10',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000157858566-y6i79z-t500x500.jpg',
      soundUrl: '',
      isTrending: true,
    ),
    Song(
      id: '6',
      name: 'Anh đếch cần gì nhiều ngoài em',
      artistId: '1',
      imageUrl:
          'https://cdn1.tuoitre.vn/zoom/600_315/2018/11/18/anh-dech-can-gi-nhieu-ngoai-em-5read-only-1542509269499734106478-crop-1542509323791550742764.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Anh%20%C4%90%E1%BA%BFch%20C%E1%BA%A7n%20G%C3%AC%20Nhi%E1%BB%81u%20Ngo%C3%A0i%20Em%20-%20%C4%90en%20ft%20V%C5%A9%20Th%C3%A0nh%20%C4%90%E1%BB%93ng.mp3?alt=media&token=2aac47f6-0c6a-47e6-af77-60314c3e7a9e',
      isTrending: true,
    ),
    Song(
      id: '7',
      name: 'Bài này chill phết',
      artistId: '1',
      imageUrl:
          'https://lyrics3s.com/wp-content/uploads/2021/10/loi-bai-hat-bai-nay-chill-phet-cover.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/B%C3%A0i%20n%C3%A0y%20chill%20ph%E1%BA%BFt%20-%20%C4%90en%20ft%20MIN.mp3?alt=media&token=7b5fe756-15a6-403a-8c71-ab1b03a9cab3',
      isTrending: true,
    ),
    Song(
      id: '8',
      name: 'Cảm ơn',
      artistId: '1',
      imageUrl:
          'https://kenh14cdn.com/2019/10/21/dsc02534-15716663816951877929793-1571670762752669941956.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/C%E1%BA%A3m%20%C6%A1n%20-%20%C4%90en%20ft%20Bi%C3%AAn.mp3?alt=media&token=008a42c6-8283-4817-a835-6329e8780315',
      isTrending: true,
    ),
    Song(
      id: '9',
      name: 'Đi về nhà',
      artistId: '1',
      imageUrl:
          'https://vtv1.mediacdn.vn/thumb_w/650/2020/12/19/nkk2664-1608348105952437410015.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Di%20Ve%20Nha%20-%20Den%20ft%20JustaTee.mp3?alt=media&token=90296108-f70a-407b-a2a6-711151b614e8',
      isTrending: true,
    ),
    Song(
      id: '10',
      name: 'Lối nhỏ',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/KKc_RMln5UY/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/L%E1%BB%91i%20Nh%E1%BB%8F%20%20-%20%C4%90en%20V%C3%A2u%20ft%20Ph%C6%B0%C6%A1ng%20Anh%20%C4%90%C3%A0o.mp3?alt=media&token=e45f4042-f4c0-49bf-bfdd-51894fb14969',
      isTrending: true,
    ),
    Song(
      id: '11',
      name: 'Mang tiền về cho mẹ',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/UVbv-PJXm14/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Mang%20Ti%E1%BB%81n%20V%E1%BB%81%20Cho%20M%E1%BA%B9%20-%20%C4%90en%20ft%20Nguy%C3%AAn%20Th%E1%BA%A3o.mp3?alt=media&token=b15123b2-b7fe-4ce4-a284-7687ad42194e',
      isTrending: true,
    ),
    Song(
      id: '12',
      name: 'Mười năm',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/L0NZW6pgSLc/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/M%C6%B0%E1%BB%9Di%20N%C4%83m%20-%20%C4%90en%20ft%20Ng%E1%BB%8Dc%20Linh.mp3?alt=media&token=42ca3d1f-ccc1-488a-95f2-a1fcd99d07f5',
      isTrending: true,
    ),
    Song(
      id: '13',
      name: 'Trốn tìm',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/Ws-QlpSltr8/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/Tron%20Tim%20-%20Den.mp3?alt=media&token=637a7c93-192e-45bf-b8c2-f7d461e49ec5',
      isTrending: true,
    ),
    Song(
      id: '14',
      name: 'Đi theo bóng mặt trời',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/XszJkmsrccI/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/%C4%90i%20Theo%20B%C3%B3ng%20M%E1%BA%B7t%20Tr%E1%BB%9Di%20-%20%C4%90en%20ft%20T%C4%83ng%20Ng%C3%A2n%20H%C3%A0%20Maius%20Philharmonic.mp3?alt=media&token=cf4c0b69-1c27-4ec6-8575-e79d66482dd2',
      isTrending: true,
    ),
    Song(
      id: '15',
      name: 'Đi trong mùa hè',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/m-7YVLOgvag/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/%C4%90i%20Trong%20M%C3%B9a%20H%C3%A8%20ft%20Nh%E1%BA%A1c%20s%C4%A9%20Tr%E1%BA%A7n%20Ti%E1%BA%BFn.mp3?alt=media&token=6149b87b-eca8-4c4a-854e-ec1e5e51d981',
      isTrending: true,
    ),
    Song(
      id: '16',
      name: 'Đưa nhau đi trốn',
      artistId: '1',
      imageUrl: 'https://i.ytimg.com/vi/xc5JQiQG8p4/maxresdefault.jpg',
      soundUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutter-hearme.appspot.com/o/%C4%90%C6%B0a%20nhau%20%C4%91i%20tr%E1%BB%91n%20-%20%C4%90en%20ft%20Linh%20C%C3%A1o.mp3?alt=media&token=8b2b1b01-d738-4235-87de-86d5cd79a44d',
      isTrending: true,
    ),
  ];
}
