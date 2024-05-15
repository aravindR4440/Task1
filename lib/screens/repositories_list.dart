
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/models/item.dart';
import 'package:task1/providers/repositories.dart';
import 'package:task1/screens/repositories_detail_screen.dart';

class RepositoriesScreen extends StatefulWidget {
  const RepositoriesScreen({super.key});

  @override
  State<RepositoriesScreen> createState() => _RepositoriesScreenState();
}

class _RepositoriesScreenState extends State<RepositoriesScreen> {

  Repositories? repositories;

  @override
  void initState() {
    repositories = Provider.of<Repositories>(context, listen: false);
    fetchDataFromServer();
    // fetchDataFromLocal();
    super.initState();
  }

  fetchDataFromLocal(){
    // String date = "2022-04-30";
    repositories!.getRepositoriesFromLocal(repositories!.date);
  }


  fetchDataFromServer(){
    repositories!.getRepositoriesFromServer(repositories!.date);
  }


  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: repositories!.getDateTime(repositories!.date),
        firstDate: DateTime(2020, 8),
        lastDate: DateTime.now()
    );
    if (picked != null) {
      repositories!.date = repositories!.getDateyyyyMMdd(picked);
    }
  }





  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<Repositories>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()async{
                await _selectDate();
                fetchDataFromServer();
                // fetchDataFromLocal();
              }, icon: const Icon(Icons.date_range,color: Colors.white,)
          ),
          SizedBox(width: 8,),
        ],
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Repositories",
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: makeBody(repo),
    );
  }

  Widget makeBody(Repositories repo){

    if(repo.loading){
      return const Center(
        child: CircularProgressIndicator(color: Colors.red,),
      );
    }

    if(repo.itemObj.items==null||repo.itemObj.items!.isEmpty){
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty,size: 35,),
            SizedBox(height: 10,),
            Text("No Repositories Found"),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: repo.itemObj.items!.length,
      itemBuilder: (BuildContext context, int index) {
        Item item = repo.itemObj.items![index];
        return ListTile(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RepositoriesDetailScreen(item: item)
                ));
          },
          trailing: const Icon(Icons.keyboard_arrow_right,
            color: Colors.redAccent,),
          leading: CircleAvatar(
            radius: 36,
            child: Image(
              image: NetworkImage(item.owner?.avatarUrl??""),
            ),
          ),
          title: Text(item.name??""),
          subtitle: Text(item.fullName??""),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return Container();
    },

    );


  }
}
