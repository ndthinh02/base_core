import 'dart:io';
import 'package:dio/dio.dart';

import 'package:base_core/core/constant/constant.dart';
import 'package:base_core/core/resources/data_state.dart';
import 'package:base_core/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:base_core/features/daily_news/domain/entities/article.dart';
import 'package:base_core/features/daily_news/domain/repository/article_repository.dart';

import '../models/article.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _service;

  ArticleRepositoryImpl(this._service);

  @override
  //khong duoc su dung entities trong data layer nen su dung article model
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse = await _service.getNewsArticles(
        apiKey:newsAPIKey,
        country:countryQuery,
        category:categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(e){
      return DataFailed(e);
    }
  }
}
