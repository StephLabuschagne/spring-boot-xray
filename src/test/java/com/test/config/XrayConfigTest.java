package com.test.config;

import com.amazonaws.xray.AWSXRayRecorder;
import com.amazonaws.xray.AWSXRayRecorderBuilder;
import com.amazonaws.xray.javax.servlet.AWSXRayServletFilter;
import com.amazonaws.xray.strategy.SegmentNamingStrategy;
import com.amazonaws.xray.strategy.sampling.NoSamplingStrategy;
import javax.servlet.Filter;
import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ActiveProfiles;

@ActiveProfiles("test")
@Configuration
public class XrayConfigTest {

  @Bean
  public AWSXRayRecorder awsXRayRecorder() {
    return AWSXRayRecorderBuilder.standard()
        .withForcedTraceIdGeneration()
        .withSamplingStrategy(new NoSamplingStrategy())
        .build();
  }
}
