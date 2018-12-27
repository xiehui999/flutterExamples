import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'person.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Person {
  Person(this.name, this.email,this.testKey);

  String name;
  String email;
  //可以另起一个名字
  @JsonKey(name: 'test_key')
  String testKey;


  // 下面为固定模式，编辑完成后，在主目录执行
  // flutter packages pub run build_runner build

  //不同的类使用不同的mixin即可
  factory Person.fromaJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
