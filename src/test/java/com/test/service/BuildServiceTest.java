package com.test.service;


import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class BuildServiceTest {

  public static final String BUILD_NUMBER = "1.0.1.1";
  @Mock
  private EnvironmentService environmentService;
  @InjectMocks
  private BuildService buildService;

  @Test
  public void testThatTheBuildNumberIsReturned(){
    when(environmentService.getBuildNumberFromEnvironments()).thenReturn(BUILD_NUMBER);
    var buildNumber = buildService.getBuildNumber();
    assertThat(buildNumber).isEqualTo(BUILD_NUMBER);
  }
}
