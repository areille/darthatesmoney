import 'package:darthatesmoney/darthatesmoney.dart';
import 'package:test/test.dart';

void main() {
  group('Darthatesmoney', () {
    const demo = Darthatesmoney(projectName: 'demo', privateCode: 'demo');
    test('can be instantiated', () {
      expect(
        demo,
        isNotNull,
      );
    });
    test('uri', () {
      expect(
        demo.projectUri.toString(),
        'https://ihatemoney.org/api/projects/demo',
      );
    });
    test('auth uri', () {
      expect(
        demo.authenticatedUri(demo.projectUri).toString(),
        'https://demo:demo@ihatemoney.org/api/projects/demo',
      );
    });
    test('get project info', () async {
      final projectInfo = await demo.getProjectInfo();
      expect(projectInfo.id, 'demo');
      expect(projectInfo.contactEmail, 'demo@notmyidea.org');
    });
    test('list project members', () async {
      final members = await demo.listMembers();
      expect(members.length, isNonNegative);
    });
  });
}
