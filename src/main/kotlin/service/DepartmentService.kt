package org.jh.service

import jakarta.persistence.EntityNotFoundException
import org.jh.entity.Employee
import org.jh.repository.DepartmentRepository
import org.jh.repository.EmployeeRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class DepartmentService (
    private val departmentRepository: DepartmentRepository,
    private val employeeRepository: EmployeeRepository
) {

    @Transactional
        fun increaseSalaries(departmentId: Long, percentageIncrease: Double) {

        println("percentageIncrease : $percentageIncrease")

        departmentRepository.findByIdOrNull(departmentId) ?: throw EntityNotFoundException("Department with ID $departmentId not found")

        val employees = employeeRepository.findByDepartmentId(departmentId)

        employees.forEach { employee ->
            println("start employee : $employee")
            val updateSalary = (employee.salary * (1 + percentageIncrease / 100)).toLong()
            println("updateSalary : $updateSalary")
            employee.salary = updateSalary
            println("employee : $employee")
        }

        employeeRepository.saveAll(employees)
    }
}