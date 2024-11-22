package org.jh.dto

import org.apache.logging.log4j.util.Strings

data class EmployeeUpdateDto (
    val firstName : String?,
    val lastName: String?,
    val email: String?,
    val phoneNumber : String?,
    val salary : Double?
)