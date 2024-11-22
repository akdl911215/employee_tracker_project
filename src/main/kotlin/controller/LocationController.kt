package org.jh.controller

import io.swagger.v3.oas.annotations.Operation
import org.jh.dto.LocationWithDepartmentsDto
import org.jh.service.LocationService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/locations")
class LocationController (
    private val locationService: LocationService
) {

    @Operation(
        summary = "Retrieve location with departments",
        description = "부서 및 위치 정보 조회 가능한 API 구현"
    )
    @GetMapping("/{id}")
    private fun getLocationWithDepartments(@PathVariable id: Long): LocationWithDepartmentsDto {
        println("getLocationWithDepartments id : $id")

        return locationService.getLocationWithDepartments(id)
    }
}