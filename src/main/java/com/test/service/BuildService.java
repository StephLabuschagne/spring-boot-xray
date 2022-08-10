package com.test.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BuildService {

  private final EnvironmentService environmentService;

  public String getBuildNumber(){
    return environmentService.getBuildNumberFromEnvironments();
  }
}
