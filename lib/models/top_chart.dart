// ignore_for_file: public_member_api_docs, sort_constructors_first
class TopChart {
  String id;
  String name;
  String imageUrl;
  TopChart({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static List<TopChart> topChartsList = [
    TopChart(
      id: '1',
      name: 'Top 100',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000399157941-z2r9pp-t500x500.jpg',
    ),
    TopChart(
      id: '2',
      name: 'Top 200',
      imageUrl:
          'https://file.tinnhac.com/resize/600x-/music/2017/05/16/b3c7049f44a4f291a27d-2acf.jpg',
    ),
    TopChart(
      id: '3',
      name: 'Top 300',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000172159575-amqr49-t500x500.jpg',
    ),
    TopChart(
      id: '4',
      name: 'Top 400',
      imageUrl:
          'https://i1.sndcdn.com/artworks-000157858566-y6i79z-t500x500.jpg',
    ),
  ];
}
