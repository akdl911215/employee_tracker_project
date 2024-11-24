package org.jh.controller

import io.swagger.v3.oas.annotations.Operation
import org.jh.service.DepartmentService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/departments")
class DepartmentController (
    private val departmentService: DepartmentService
) {

    data class SalaryIncreaseRequest(
        val percentageIncrease: Double
    )

    @Operation(
        summary = "Increase Salaries for a Specific Department by a Specified Percentage",
        description = "특정 부서의 급여를 특정 비율로 인상 할 수 있는 할 수 있는 API 구현"
    )
    @PatchMapping("/{departmentId}/increase-salaries")
    fun increaseSalaries(
        @PathVariable("departmentId") departmentId: Long,
        @RequestBody body: SalaryIncreaseRequest
    ): ResponseEntity<String> {

        departmentService.increaseSalaries(departmentId, body.percentageIncrease)

        return ResponseEntity.ok("Salaries increased by ${body.percentageIncrease}% for department $departmentId.")}
}