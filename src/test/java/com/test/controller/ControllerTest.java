package com.test.controller;


import static com.jayway.restassured.RestAssured.given;
import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.DEFINED_PORT;

import java.util.UUID;
import org.apache.http.HttpStatus;
import org.hamcrest.Matchers;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

@ActiveProfiles("test")
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = DEFINED_PORT)
public class ControllerTest {

    private static final Logger LOG = LoggerFactory.getLogger(ControllerTest.class);

    private String productId = UUID.randomUUID().toString();

    @Test
    public void assertThatControllerRespondsWithBuildNumber() {
        given().
                port(8080).
                when().
                get("/").
                then().
                statusCode(HttpStatus.SC_OK).
                body("buildNumber", Matchers.is("1.0.1.1"));
    }
}
