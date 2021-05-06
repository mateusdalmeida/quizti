import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizti/mobx/disciplinasController.dart';
import 'package:quizti/mobx/questsController.dart';
import 'package:quizti/mobx/quizController.dart';
import 'package:quizti/widgets/detailsItem.dart';
import 'package:quizti/mobx/assuntosController.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quizti/widgets/miniButton.dart';
import 'package:quizti/utils.dart';

class RunTest extends StatelessWidget {
  final Map listOfIndex;
  final List assuntoMaterial = [];

  RunTest(this.listOfIndex);

  @override
  Widget build(BuildContext context) {
    final questsController = Provider.of<QuestsController>(context);
    final assuntosController = Provider.of<AssuntosController>(context);
    final quizController = Provider.of<QuizController>(context);
    final disciplinasController = Provider.of<DisciplinasController>(context);

    String disciplinaId =
        quizController.quizzesMap[listOfIndex['quiz']]['disciplina'];

    String disciplinaName =
        disciplinasController.disciplinasMap[disciplinaId]['nome'];

    Map quests = {};
    listOfIndex['quest'].keys.toList().forEach((id) {
      var temp = [];
      temp = questsController.questsList
          .where((quest) => quest['id'] == id)
          .toList();
      quests[id] = temp[0];
    });
    List assuntos =
        quizController.quizzesMap[listOfIndex['quiz']]['assunto'].keys.toList();
    assuntos.forEach((id) {
      if (assuntosController.assuntosMap[id]['material'] != null) {
        assuntoMaterial.addAll(assuntosController.assuntosMap[id]['material']);
      }
    });
    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Detalhes do teste",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  Text(disciplinaName,
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  Visibility(
                      visible: this.assuntoMaterial.length > 0,
                      child: materialAssunto())
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(200)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: listOfIndex['quest'].length,
            itemBuilder: (context, index) {
              Map solvedDetails = listOfIndex['quest'].values.toList()[index];
              Map quest = quests[listOfIndex['quest'].keys.toList()[index]];
              return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            assuntosController.assuntosMap[quest['assunto']]
                                    ['nome']
                                .toString(),
                            style: TextStyle(fontSize: 20)),
                        DetailsItem(quest['pergunta']),
                        SizedBox(height: 8),
                        Text("Resposta Correta:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        DetailsItem(
                            quest['alternativas'][quest['correta'].toString()]),
                        Text(
                          solvedDetails['result'] ? "Acertou" : "Errou",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: solvedDetails['result']
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        Text("Tempo: " + getHora(solvedDetails['time']),
                            style: TextStyle(fontSize: 16)),
                        respostaEscolhida(solvedDetails, quest['alternativas']),
                        solucao(quest['resolucao']),
                        materialQuestao(quest['material'])
                      ]));
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          child: Text("Voltar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget materialQuestao(String material) {
    if (material == null)
      return SizedBox();
    else {
      return Container(
          margin: EdgeInsets.only(top: 8),
          child: MiniButton("Baixar Material", minWidth: double.infinity,
              onPressed: () async {
            if (await canLaunch(material)) {
              await launch(material);
            } else {
              throw 'Could not launch';
            }
          }));
    }
  }

  Widget materialAssunto() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Material do assunto - PDF",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Container(
            height: 40,
            child: ListView.separated(
                itemCount: this.assuntoMaterial.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (await canLaunch(this.assuntoMaterial[index])) {
                        await launch(this.assuntoMaterial[index]);
                      } else {
                        throw 'Could not launch';
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text((index + 1).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )),
                  );
                }),
          )
        ]);
  }

  Widget respostaEscolhida(solvedDetails, alternativas) {
    if (solvedDetails['escolha'] == null) {
      return SizedBox();
    } else if (!solvedDetails['result']) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Text("Alternativa Escolhida:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DetailsItem(alternativas[solvedDetails['escolha'].toString()]),
        ],
      );
    }
    return SizedBox();
  }

  Widget solucao(Map solucao) {
    bool exibir = false;
    if (solucao != null) {
      if (solucao.isEmpty)
        exibir = false;
      else
        exibir = true;
    }
    if (!exibir) {
      return SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Text("Resolução:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DetailsItem(solucao)
        ],
      );
    }
  }
}
