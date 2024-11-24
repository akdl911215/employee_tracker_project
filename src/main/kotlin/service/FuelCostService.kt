package org.jh.service

import io.github.cdimascio.dotenv.Dotenv
import org.springframework.stereotype.Service
import okhttp3.OkHttpClient
import okhttp3.Request
import com.fasterxml.jackson.databind.ObjectMapper

@Service
class FuelCostService {
    private val dotenv = Dotenv.load()
    private val httpClient = OkHttpClient()
    private val objectMapper = ObjectMapper()

    fun getFuelCost(pageNo: Int, numOfRows: Int): List<Map<String, Any>> {
        val baseUrl: String = dotenv["PUBLIC_API_BASE_URL"]
            ?: throw RuntimeException("Environment variable PUBLIC_API_BASE_URL not found")
        val serviceKey: String = dotenv["PUBLIC_API_SERVICE_KEY"]
            ?: throw RuntimeException("Environment variable PUBLIC_API_SERVICE_KEY not found")

        val url = "$baseUrl?" +
                "serviceKey=$serviceKey" +
                "&dataType=json" +
                "&pageNo=$pageNo" +
                "&numOfRows=$numOfRows" +
                "&fuelType=원자력"

        val request = Request.Builder()
            .url(url)
            .get()
            .build()

        val response = httpClient.newCall(request).execute()

        if (!response.isSuccessful) {
            throw RuntimeException("Failed to fetch data: ${response.code}")
        }

        val rawJson = response.body?.string()
            ?: throw RuntimeException("Empty response body")

        return parseAndFormatResponse(rawJson)
    }
    private fun parseAndFormatResponse(rawJson: String): List<Map<String, Any>> {
        val node = objectMapper.readTree(rawJson)
        val itemsNode = node
            .path("response")
            .path("body")
            .path("items")
            .path("item")

        if (!itemsNode.isArray) {
            throw RuntimeException("Unexpected JSON format: 'item' is not an array")
        }

        return itemsNode.map { itemNode ->
            mapOf(
                "fuelType" to itemNode.path("fuelType").asText(),
                "unit" to itemNode.path("unit").asText(),
                "cost" to itemNode.path("untpc").asDouble(),
                "date" to itemNode.path("day").asText()
            )
        }
    }
}