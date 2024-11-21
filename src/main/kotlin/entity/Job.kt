package org.jh.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table



@Entity
@Table(name = "jobs")
data class Job(
    @Id
    @Column(name = "job_id")
    val id: String,

    @Column(name = "job_title")
    val title: String,

    @Column(name = "min_salary")
    val minSalary: Double? = null,

    @Column(name = "max_salary")
    val maxSalary: Double? = null
)
