package org.jh.controller

import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.media.ExampleObject
import org.jh.dto.FuelCostResponse
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.jh.service.FuelCostService



@RestController
@RequestMapping("/fuel-cost")
class FuelCostController (
    private val fuelCostService: FuelCostService
) {

    @Operation(
        summary = "Get fuel cost data",
        description = "공공 데이터 포털 API 구현"
    )
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Successful response",
                content = [
                    Content(
                        mediaType = "application/json",
                        schema = Schema(implementation = FuelCostResponse::class),
                        examples = [
                            ExampleObject(
                                name = "Example Response",
                                value = """
                                [
                                  {
                                    "fuelType": "유연탄",
                                    "unit": "원/GCAL",
                                    "cost": 53110.85,
                                    "date": "202411"
                                  },
                                  {
                                    "fuelType": "원자력",
                                    "unit": "원/GCAL",
                                    "cost": 2539.85,
                                    "date": "202411"
                                  }
                                ]
                                """
                            )
                        ]
                    )
                ]
            )
        ]
    )
    @GetMapping
    fun getFuelCost(
        @RequestParam("pageNo", defaultValue = "1") pageNo: Int,
        @RequestParam("numOfRows", defaultValue = "30") numOfRows: Int
    ): ResponseEntity<List<Map<String, Any>>> {
        val response = fuelCostService.getFuelCost(pageNo, numOfRows)

        return ResponseEntity.ok(response)
    }
}