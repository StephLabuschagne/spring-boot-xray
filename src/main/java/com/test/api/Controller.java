package com.test.api;

import com.test.dto.Response;
import com.test.service.BuildService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController()
@RequiredArgsConstructor
public class Controller {

  private final BuildService buildService;

  @GetMapping()
  public Response getBuildNumber() {
    return Response.builder().buildNumber(buildService.getBuildNumber()).build();
  }

}
