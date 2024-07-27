import 'package:checklist/app/features/configurations/controllers/configurations_controller.dart';
import 'package:checklist/app/features/configurations/dao/interface/configurations_dao.dart';
import 'package:checklist/app/features/configurations/models/configurations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ConfigurationsDAO>()])
import "configurations_controller_test.mocks.dart";

void main() {
  late ConfigurationsController configurationsController;
  late ConfigurationsDAO configurationsDAO;
  setUp(() {
    configurationsDAO = MockConfigurationsDAO();

    configurationsController =
        ConfigurationsController(configurationsDAO: configurationsDAO);

    configurationsController.config.darkMode = false;
  });

  group("loadConfig method", () {
    test("shod load the configurations model from db", () async {
      Configurations configLoadedTest = Configurations.empty();
      when(configurationsDAO.getConfig())
          .thenAnswer((_) async => Configurations.empty());

      await configurationsController.loadConfigs();

      expect(configurationsController.config, isA<Configurations>());
      expect(configurationsController.config, equals(configLoadedTest));
      verify(configurationsDAO.getConfig()).called(1);
    });
  });

  group("toggleDarkMode method", () {
    test("should toggle the darkmode of the config model and save", () async {
      when(configurationsDAO.updateConfigs(configurationsController.config))
          .thenAnswer((_) async => 1);

      await configurationsController.toggleDarkMode();

      expect(configurationsController.config.darkMode, isTrue);

      verify(configurationsDAO.updateConfigs(configurationsController.config))
          .called(1);
    });
  });

  tearDown(() {});
}
