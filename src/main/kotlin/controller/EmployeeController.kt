package org.jh.controller

import io.swagger.v3.oas.annotations.Operation
import org.jh.dto.EmployeeDto
import org.jh.dto.EmployeeUpdateDto
import org.jh.dto.EmployeeWithHistoryDto
import org.jh.service.EmployeeService
import org.springdoc.core.parsers.KotlinCoroutinesReturnTypeParser
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/employees")
class EmployeeController(
    private val service: EmployeeService,
    private val kotlinCoroutinesReturnTypeParser: KotlinCoroutinesReturnTypeParser
) {

    @Operation(
        summary = "Find by id employee",
        description = "특정 사원의 현재 정보 조회 가능한 API 구현"
    )
    @GetMapping("/{id}")
    fun getEmployeeById(@PathVariable id: Long): EmployeeDto {
        return service.getEmployeeById(id)
    }

    @Operation(
        summary = "Retrieve employee with history",
        description = "특정 사원의 이력 정보 조회 가능한 API 구현"
    )
    @GetMapping("/{id}/history")
    fun getEmployeeWithHistory(@PathVariable id: Long): EmployeeWithHistoryDto {
        return service.getEmployeeWithHistory(id)
    }

    @Operation(
        summary = "Update employee information",
        description = "사원 정보를 업데이트 할 수 있는 API 구현"
    )
    @PatchMapping("/{id}")
    fun updateEmployee(
        @PathVariable id: Long,
        @RequestBody updateDto: EmployeeUpdateDto
    ): ResponseEntity<EmployeeDto> {
        val updateEmployee = service.updateEmployee(id, updateDto)

        return ResponseEntity.ok(updateEmployee)
    }
}