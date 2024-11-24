package org.jh.dto


data class EmployeeUpdateDto (
    val firstName : String?,
    val lastName: String?,
    val email: String?,
    val phoneNumber : String?,
    val salary : Long?
)