package org.jh.entity
import java.io.Serializable
import java.time.LocalDate

data class JobHistoryId(
    val employeeId: Long = 0,
    val startDate: LocalDate = LocalDate.now()
) : Serializable
