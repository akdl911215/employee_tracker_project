package org.jh.dto

import java.time.LocalDate

data class JobHistoryDto (
    val employeeId: Long,
    val departmentId: Long,
    val jobId: String,
    val startData: LocalDate,
    val endDate: LocalDate,
)