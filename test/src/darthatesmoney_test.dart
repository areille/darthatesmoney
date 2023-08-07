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
    test('auth headers', () {
      expect(demo.authHeader.key, 'authorization');
      expect(demo.authHeader.value, 'Basic ZGVtbzpkZW1v');
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
