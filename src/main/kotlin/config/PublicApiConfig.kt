package org.jh.config

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration

@Configuration
@ConfigurationProperties(prefix = "public-api")
class PublicApiConfig {
    lateinit var baseUrl: String
}