package org.jh.service

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import org.jh.config.PublicApiConfig
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate

@Service
class FuelCostService (
    private val restTemplate: RestTemplate,
    @Value("\${public-api.base-url}") private val baseUrl: String
) {

    fun getFuelCost(fuelType: String, pageNo: Int, numOfRows: Int): String {
        val apiUrl = baseUrl
        if (apiUrl.isBlank()) throw RuntimeException("Base URL is missing or not configured")
        println("Config Base URL: $apiUrl")

        val url = "$apiUrl&pageNo=$pageNo&numOfRows=$numOfRows&fuelType=$fuelType"
        println("Request URL: $url")

        val response = restTemplate.getForObject(url, String::class.java)
            ?: throw RuntimeException("Failed to fetch data")

        return response
    }
  }