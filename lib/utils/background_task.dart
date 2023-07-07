import 'dart:isolate';

class BackgroundTask{


  static _doIsolate(BackgroundParams params){
    params.sendPort.send("message from isolate");
    print("calling Isolate");

  }
 static callIsolate() async {
    ReceivePort receivePort=ReceivePort();
  final isolate=  await Isolate.spawn(_doIsolate, BackgroundParams(sendPort: receivePort.sendPort));

    String message = await receivePort.first;
    isolate.kill(priority: Isolate.immediate);
    print(message);
  }
}
class BackgroundParams{
  final SendPort sendPort;
  BackgroundParams({required this.sendPort});
}