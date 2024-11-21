package org.jh.dto

import org.jh.entity.Employee
import org.jh.entity.JobHistory

data class EmployeeWithHistoryDto (
    val employee: Employee?,
    val jobHistory: List<JobHistory>
)