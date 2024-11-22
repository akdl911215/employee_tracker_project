package org.jh.service

import jakarta.persistence.EntityNotFoundException
import org.jh.dto.EmployeeDto
import org.jh.dto.EmployeeUpdateDto
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

    fun updateEmployee(id: Long, updateDto: EmployeeUpdateDto): EmployeeDto {
        val employee: Employee = employeeRepository.findByIdOrNull(id)
            ?: throw EntityNotFoundException("Employee with id $id not found")

        val updatedEmployee = employee.copy(
            firstName = updateDto.firstName ?: employee.firstName,
            lastName = updateDto.lastName ?: employee.lastName,
            email = updateDto.email ?: employee.email,
            phoneNumber = updateDto.phoneNumber ?: employee.phoneNumber,
            salary = updateDto.salary ?: employee.salary
        )

        val saveEmployee: Employee = employeeRepository.save(updatedEmployee)
        return mapToDto(saveEmployee)

    }

    private fun mapToDto(employee: Employee): EmployeeDto {
        return EmployeeDto(
            id = employee.id ?: throw IllegalArgumentException("Employee ID cannot be null"),
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

    @Transactional(readOnly = true)
    fun getEmployeeById(id: Long): EmployeeDto {
        val employee: Employee = employeeRepository.findById(id)
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