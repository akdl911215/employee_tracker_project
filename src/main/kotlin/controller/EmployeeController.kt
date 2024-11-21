package org.jh.controller

import io.swagger.v3.oas.annotations.Operation
import org.jh.dto.EmployeeDto
import org.jh.dto.EmployeeWithHistoryDto
import org.jh.service.EmployeeService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/employees")
class EmployeeController(private val service: EmployeeService) {

    @Operation(summary = "Find by id employee", description = "Retrieve a specific employee")
    @GetMapping("/{id}")
    fun getEmployeeById(@PathVariable id: Long): EmployeeDto {
        return service.getEmployeeById(id)
    }

    @Operation(
        summary = "Retrieve employee with history",
        description = "Retrieve a specific employee along with their job history, including details about past roles and departments"
    )
    @GetMapping("/history/{id}")
    fun getEmployeeWithHistory(@PathVariable id: Long): EmployeeWithHistoryDto {
        return service.getEmployeeWithHistory(id)
    }
}