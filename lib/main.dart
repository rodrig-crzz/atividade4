import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

const Color backGroundColor = Colors.grey;
const Color primaryColor = Colors.lightGreen;
const Color secondaryColor = Colors.white;

String pagSequence = '';
String pagNumber = '';
List<String> results = [];
int i = 0;

main() => runApp(const SubstitutionAlgorithms());

class SubstitutionAlgorithms extends StatelessWidget {
  const SubstitutionAlgorithms({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Simulator(),
    );
  }
}

class Simulator extends StatelessWidget {
  const Simulator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backGroundColor,
      body: Center(
        child: SizedBox(
          height: 500,
          width: 750,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimulatorTitle(),
                  MainScreen(),
                ],
              ),
              Results(),
            ],
          ),
        ),
      ),
    );
  }
}

class SimulatorTitle extends StatelessWidget {
  const SimulatorTitle({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 490,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: const Center(
        child: StrokeText(
          text: 'Trabalho de SO',
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
          strokeColor: Colors.black,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  TextEditingController pn = TextEditingController();
  TextEditingController ps = TextEditingController();
  String erro = '';

  void lru_process() {
    if (pagSequence == '' || pagNumber == ''){
      erro = '     ERRO';
      setState(() {});
      return;
    }
    else {
      erro = '';
      setState(() {});
    }

    int i = 0;
    String aux = '';
    List<String> auxList = [];

    while (true) {
      aux = '$aux${pagSequence[i]}';
      i++;
      if (i == pagSequence.length) {
        auxList.add(aux);
        break;
      }
      else if (pagSequence[i] == ' ') {
        auxList.add(aux);
        aux = '';
        i++;
      }
    }

    results.clear();
    List<String> pagList_lru = [];
    List<String> lastest = [];

    for (String i in auxList) {
      if (pagList_lru.length < int.parse(pagNumber)) {
        pagList_lru.add(i);
        lastest.add(i);
        results.add('MISS');
      } else {
        if (pagList_lru.contains(i)) {
          results.add('HIT');
          lastest.remove(i);
          lastest.add(i);
        } else {
          results.add('MISS');
          pagList_lru.remove(lastest[0]);
          lastest.removeAt(0);
          pagList_lru.add(i);
          lastest.add(i);
        }
      }
    }
  }

  void fifo_process() {

    if (pagSequence == '' || pagNumber == ''){
      erro = '     ERRO';
      setState(() {});
      return;
    }
    else {
      erro = '';
      setState(() {});
    }

    int i = 0;
    String aux = '';
    List<String> auxList = [];

    while (true) {
      aux = '$aux${pagSequence[i]}';
      i++;
      if (i == pagSequence.length) {
        auxList.add(aux);
        break;
      }
      else if (pagSequence[i] == ' ') {
        auxList.add(aux);
        aux = '';
        i++;
      }
    }

    results.clear();
    List<String> pagList_fifo = [];

    for (String i in auxList) {

      if (pagList_fifo.contains(i)) {
        results.add('HIT');
        continue;
      }
      else if (pagList_fifo.length < int.parse(pagNumber)) {
        pagList_fifo.add(i);
      }
      else {
        pagList_fifo.removeAt(0);
        pagList_fifo.add(i);
      }
      results.add('MISS');

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 490,
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Memória Virtual - Páginas',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            width: 450,
            child: TextField(
              controller: ps,
              onChanged: (value) {
                pagSequence = value;
              },
              decoration: const InputDecoration(
                helperText: 'Ex.: 1 2 6 5',
                labelText: 'Sequência de Páginas:',
              ),
              //local de controle de variável
              // controller: i,
            ),
          ),
          SizedBox(
            width: 450,
            child: TextField(
              controller: pn,
              onChanged: (value) {
                pagNumber = value;
              },
              decoration: const InputDecoration(
                helperText: 'Ex.: 3',
                labelText: 'Número de Páginas na Memória Principal:',
              ),
              //local de controle de variável
              // controller: i,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => lru_process(),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(primaryColor),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  fixedSize: const MaterialStatePropertyAll<Size>(Size(150, 50)),
                ),
                child: const Text(
                  'LRU',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => fifo_process(),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(primaryColor),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  fixedSize: const MaterialStatePropertyAll<Size>(Size(150, 50)),
                ),
                child: const Text(
                  'FIFO',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              erro,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),),
        ],
      ),
    );
  }
}

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}
class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 470,
          width: 240,
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
        ),
        Positioned(
          top: 10,
          child: Container(
            height: 350,
            width: 210,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (c, index) {
                  return ListTile(
                    title: Text(
                      results[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: ElevatedButton(
            onPressed: () => setState(() {}),
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll<Color>(primaryColor),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              fixedSize: const MaterialStatePropertyAll<Size>(Size(150, 50)),
            ),
            child: const Text(
              'test',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        ),
      ],
    );
  }
}