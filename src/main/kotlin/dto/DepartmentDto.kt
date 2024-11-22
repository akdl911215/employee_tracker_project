package org.jh.dto

data class DepartmentDto(
    val departmentId: Long,
    val departmentName: String,
    val managerId: Long?
)