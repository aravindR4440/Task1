
import 'package:flutter/material.dart';
import 'package:task1/models/item.dart';

import '../widgets/url_textfield_widget.dart';

class RepositoriesDetailScreen extends StatelessWidget {
  final Item item;
  const RepositoriesDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(item.name??"",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.fullName??"",style:const TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(item.visibility??"",style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  if(item.description!=null)
                  const SizedBox(height: 8,),
                  if(item.description!=null)
                  Text(item.description??""),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 6,
                          ),
                          const SizedBox(width: 5,),
                          Text(item.language??"",style: const TextStyle(color: Colors.black87,
                              fontWeight: FontWeight.bold,fontSize: 16),)
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Fork:"),
                          const SizedBox(width: 5,),
                          Text("${item.forksCount??0}",style: const TextStyle(
                              fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            UrlTextField(label: 'Html url',value: item.htmlUrl??"",),
            UrlTextField(label: 'Url',value: item.url??"",),
            UrlTextField(label: 'Forks url',value: item.forksUrl??"",),
            UrlTextField(label: 'Keys url',value: item.keysUrl??"",),
            UrlTextField(label: 'Collaborators url',value: item.collaboratorsUrl??"",),
            UrlTextField(label: 'Teams url',value: item.teamsUrl??"",),
            UrlTextField(label: 'Hooks url',value: item.hooksUrl??"",),
          ],
        ),
      ),
    );
  }



}
