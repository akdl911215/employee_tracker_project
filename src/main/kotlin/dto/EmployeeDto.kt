package org.jh.dto


data class EmployeeDto(
    val id: Long,
    val firstName: String,
    val lastName: String,
    val email: String,
    val phoneNumber: String?,
    val salary: Double,
    val hireDate: String,
    val jobTitle: String
)