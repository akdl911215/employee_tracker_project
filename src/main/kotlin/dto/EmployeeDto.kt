package org.jh.dto


data class EmployeeDto(
    val id: Long,
    val firstName: String,
    val lastName: String,
    val email: String,
    val phoneNumber: String?,
    val salary: Long,
    val hireDate: String,
    val jobId: String,
    val commissionPct: Double?,
    val managerId: Long?,
    val departmentId: Long?
)