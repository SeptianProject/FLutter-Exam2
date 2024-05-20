import 'package:belajar_api/model/album.dart';
import 'package:belajar_api/services/album_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final titleController = TextEditingController();
  List<Album> albums = [];
  bool isLoading = true;

  void fetchAlbums() async {
    final result = await AlbumService.fetchAlbum();
    albums = result;
    setState(() {});
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: Border.all(color: Colors.black, width: 0.3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'EXAM 2 API',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xff5A7BFA),
            ))
          : ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(album.thumbnailUrl),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        '${album.id}. ${album.title}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        album.url,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              deleteAlbum(index);
                            },
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              showEditDialog(context, index);
                            },
                            icon: const Icon(CupertinoIcons.square_pencil)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void deleteAlbum(int index) {
    setState(() {
      albums.removeAt(index);
    });
  }

  void editAlbum(
      int index, String newTitle, String newUrl, String newThumbnailUrl) {
    setState(() {
      albums[index].title = newTitle;
      albums[index].url = newUrl;
      albums[index].thumbnailUrl = newThumbnailUrl;
    });
  }

  void showEditDialog(BuildContext context, int index) {
    TextEditingController albumidController =
        TextEditingController(text: albums[index].title.toString());
    TextEditingController urlController =
        TextEditingController(text: albums[index].url);
    TextEditingController thumbnailUrlController =
        TextEditingController(text: albums[index].thumbnailUrl);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Album'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: albumidController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
              TextField(
                controller: thumbnailUrlController,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                editAlbum(index, albumidController.text, urlController.text,
                    thumbnailUrlController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
