package org.jh.service

import org.jh.dto.EmployeeDto
import org.jh.dto.EmployeeWithHistoryDto
import org.jh.entity.Employee
import org.jh.entity.JobHistory
import org.jh.repository.EmployeeRepository
import org.jh.repository.JobHistoryRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class EmployeeService(
    private val employeeRepository: EmployeeRepository,
    private val jobHistoryRepository: JobHistoryRepository,
    ) {

    @Transactional(readOnly = true)
    fun getEmployeeById(id: Long): EmployeeDto {
        val employee = employeeRepository.findById(id)
            .orElseThrow { RuntimeException("Employee not found with ID: $id") }

        return EmployeeDto(
            id = employee.id!!,
            firstName = employee.firstName,
            lastName = employee.lastName,
            email = employee.email,
            phoneNumber = employee.phoneNumber,
            salary = employee.salary,
            hireDate = employee.hireDate.toString(),
            jobId = employee.job.id,
            commissionPct = employee.commissionPct,
            managerId = employee.managerId,
            departmentId = employee.departmentId,
        )
    }

    fun getEmployeeWithHistory(employeeId: Long): EmployeeWithHistoryDto {
        val employee: Employee? = employeeRepository.findByIdOrNull(employeeId)
        val jobHistory: List<JobHistory> = jobHistoryRepository.findAllByEmployeeId(employeeId)

        return EmployeeWithHistoryDto(
            employee = employee,
            jobHistory = jobHistory
        )
    }
}