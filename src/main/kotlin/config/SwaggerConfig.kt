package org.jh.config

import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.info.Info
import org.springdoc.core.models.GroupedOpenApi
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class SwaggerConfig {

    @Bean
    fun customOpenAPI(): OpenAPI {
        return OpenAPI()
            .info(
                Info()
                    .title("Employee Tracker")
                    .description("API Documentation")
                    .version("1.0")
            )
    }

    @Bean
    fun employeeApi(): GroupedOpenApi {
        return GroupedOpenApi.builder()
            .group("employees")
            .pathsToMatch("/employees/**")
            .build()
    }

    @Bean
    fun locationApi(): GroupedOpenApi {

        println("Registering Location API in Swagger")
        return GroupedOpenApi.builder()
            .group("locations")
            .pathsToMatch("/locations/**")
            .build()
    }
}