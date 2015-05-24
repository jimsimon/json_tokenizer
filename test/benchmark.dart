import "package:json_tokenizer/json_validator.dart" as t;
import "package:json_tokenizer/json_validator2.dart" as t2;
import "package:json_tokenizer/json_validator3.dart" as t3;
import "package:json_tokenizer/json_validator4.dart" as t4;

runSuite(iterationCount) {
  runBenchmark("JsonValidator1", new t.JsonValidator(), iterationCount);
  runBenchmark("JsonValidator2", new t2.JsonValidator(), iterationCount);
  runBenchmark("JsonValidator3", new t3.JsonValidator(), iterationCount);
  runBenchmark("JsonValidator4", new t4.JsonValidator(), iterationCount);
}

runBenchmark(name, validator, iterationCount) {
  DateTime start = new DateTime.now();
  for (int i = 0; i < iterationCount; i++) {
    benchmark(validator);
  }
  DateTime end = new DateTime.now();
  print("$name Time ($iterationCount iterations): ${end.difference(start).inMilliseconds}");
}

main() {
  runSuite(10);
  runSuite(10000);
  runSuite(100000);
}

benchmark(validator) {
  validator.isValid("1");
  validator.isValid("1.1");
  validator.isValid('"hello"');
  validator.isValid("true");
  validator.isValid("false");
  validator.isValid("{}");
  validator.isValid('{"hello": "value"}');
  validator.isValid('{"hello": "value", "world": "value2", "!": "value3"}');
  validator.isValid('[]');
  validator.isValid('["hello"]');
  validator.isValid('["hello", "world", "!"]');
  validator.isValid('[{}]');
  validator.isValid('[{},{}]');
  validator.isValid('[{"hello":"world"}]');
  validator.isValid('[{"hello":"world"},{"alas":"goodbye"}]');
  validator.isValid('[{"hello":"world"},123,"goodbye",true]');
  validator.isValid('[[],[]]');
  validator.isValid('{"array":[]}');
  validator.isValid('{"array":["hello"]}');
  validator.isValid('{"array":["hello","world"]}');
  validator.isValid('{"array":["hello","world",123,true,1.1]}');
  validator.isValid('{"array":["hello","world",123,true,1.1], "good": null, "this": 123, "works": [9]}');
  validator.isValid('{"array":{}}');
}