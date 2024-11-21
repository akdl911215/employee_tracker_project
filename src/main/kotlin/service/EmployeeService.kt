package org.jh.service

import org.jh.dto.EmployeeDto
import org.jh.entity.Employee
import org.jh.repository.EmployeeRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class EmployeeService(private val employeeRepository: EmployeeRepository) {

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
            jobTitle = employee.job.title
        )
    }

}