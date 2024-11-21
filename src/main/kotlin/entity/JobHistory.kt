package org.jh.entity

import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(name = "job_history")
@IdClass(JobHistoryId::class)
data class JobHistory (
    @Id
    @Column(name = "employee_id", nullable = false)
    val employeeId: Long,

    @Id
    @Column(name = "start_date", nullable = false)
    val startDate: LocalDate,

    @Column(name = "end_date", nullable = true)
    val endDate: LocalDate?,

    @Column(name = "job_id", nullable = false)
    val jobId: String,

    @Column(name = "department_id", nullable = false)
    val departmentId: Long
)