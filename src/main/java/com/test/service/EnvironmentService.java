package com.test.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EnvironmentService {

  @Value("${cicd.buildnumber}")
  private String buildNumber;

  public String getBuildNumberFromEnvironments(){
    return buildNumber;
  }
}
