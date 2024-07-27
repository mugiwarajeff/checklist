import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:checklist/app/features/configurations/dao/interface/configurations_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<ConfigurationsDAO>()])
import "configurations_controller_test.mocks.dart";

void main() {
  late ConfigurationsController configurationsController;
  late ConfigurationsDAO configurationsDAO;
  setUp(() {
    configurationsDAO = MockConfigurationsDAO();

    configurationsController =
        ConfigurationsController(configurationsDAO: configurationsDAO);
  });

  group("loadConfig method", () {});

  tearDown(() {});
}
