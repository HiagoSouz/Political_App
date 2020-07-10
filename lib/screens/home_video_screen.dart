import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_a/models/channel_models.dart';
import 'package:p_a/models/video_model.dart';
import 'package:p_a/screens/video_screen.dart';
import 'package:p_a/services/API_services.dart';


class HomeVideoScreen extends StatefulWidget {
  @override
  _HomeVideoScreenState createState() => _HomeVideoScreenState();
}

class _HomeVideoScreenState extends State<HomeVideoScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC0NtqwtL1oLxwm3lx_Uo5Og');
    setState(() {
      _channel = channel;
    });
  }

  _buildVideo(Video video) {
    double tamanho = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoScreen(
                  id: video.id,
                  titulo: video.title,
                  description: video.description,
                ),
              ),
            ),
        child: Container(
            height: tamanho / 5,
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop),
                        image: NetworkImage(video.thumbnailUrl),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: tamanho * 0.021856,
                            ),
                            Text(video.title,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: tamanho * 0.018970,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                textAlign: TextAlign.start),
                            SizedBox(
                              height: tamanho * 0.015971,
                            ),
                          ],
                        )),
                  ),
                ))));
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(
        playlistId: "PLNoTZ80K4L222PAN6e3U-nxaMHdGNJrRt");
    print(_channel.uploadPlaylistId);

    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container();
                  }
                  Video video = _channel.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
