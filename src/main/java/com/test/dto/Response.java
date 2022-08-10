package com.test.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class Response {
  String buildNumber;
}
