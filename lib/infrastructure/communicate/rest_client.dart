import 'package:dio/dio.dart';
import 'package:my_portfolio/infrastructure/communicate/sever_api_interface.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://example.com/api/v1/')
abstract class RestClient implements SeverApiInterface {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @override
  @GET('/about')
  Future<AboutResponse> aboutIndex(AboutRequest request);

  @override
  @GET('/contents')
  Future<ContentResponse> contentIndex(ContentRequest request);

  @override
  @GET('/core_skill')
  Future<CoreSkillResponse> coreSkillIndex(CoreSkillRequest request);

  @override
  @GET('/software_skill')
  Future<SoftwareSkillResponse> softwareSkillIndex(
    SoftwareSkillRequest request,
  );

  @override
  @GET('/experience')
  Future<ExperienceResponse> experienceIndex(ExperienceRequest request);
}
