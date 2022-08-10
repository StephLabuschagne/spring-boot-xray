package com.test.service;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.RANDOM_PORT;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@ActiveProfiles("test")
@SpringBootTest(webEnvironment = RANDOM_PORT)
public class EnvironmentServiceTest {

  public static final String BUILD_NUMBER = "1.0.1.1";

  @Autowired
  private EnvironmentService environmentService;

  @Test
  public void testThatBuildNumberIsProvided(){
    var buildNumber= environmentService.getBuildNumberFromEnvironments();
    assertThat(buildNumber).isEqualTo(BUILD_NUMBER);
  }
}
