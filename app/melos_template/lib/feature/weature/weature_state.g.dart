// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weature_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherStateImpl _$$WeatherStateImplFromJson(Map<String, dynamic> json) =>
    _$WeatherStateImpl(
      isLoading: json['isLoading'] as bool,
      weatherData: json['weatherData'] == null
          ? null
          : WeatherData.fromJson(json['weatherData'] as Map<String, dynamic>),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$WeatherStateImplToJson(_$WeatherStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'weatherData': instance.weatherData,
      'errorMessage': instance.errorMessage,
    };
