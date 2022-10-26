class SanityClient {
  SanityClient(
      {required this.projectId,
      required this.dataset,
      required this.useCdn,
      required this.apiVersion,
      required this.token});
  final String projectId;
  final String dataset;
  final bool useCdn;
  final String apiVersion;
  final String token;
}

final SanityClient sanityClient = SanityClient(
  projectId: 'projectId',
  dataset: 'production',
  useCdn: true,
  apiVersion: '2022-03-13',
  token: 'token',
);
