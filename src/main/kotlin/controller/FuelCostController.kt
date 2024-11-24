package org.jh.controller

import org.jh.service.FuelCostService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
class FuelCostController (
    private val fuelCostService: FuelCostService
) {

    @GetMapping("/fuel-cost")
    private fun getFuelCost(
        @RequestParam(value = "fuelType", required = true) fuelType: String,
        @RequestParam(value = "pageNo", required = false, defaultValue = "1") pageNo: Int,
        @RequestParam(value = "numOfRaws", required = false, defaultValue = "30") numOfRaws: Int,
    ): ResponseEntity<String> {
        val response = fuelCostService.getFuelCost(fuelType, pageNo, numOfRaws)

        return ResponseEntity.ok(response)
    }
}