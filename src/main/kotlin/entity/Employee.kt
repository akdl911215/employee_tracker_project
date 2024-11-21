package org.jh.entity

import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(name = "employees")
data class Employee (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "employee_id")
    var id: Long? = null,

    @Column(name = "first_name")
    val firstName: String,

    @Column(name = "last_name")
    val lastName: String,

    @Column(name = "email")
    val email: String,

    @Column(name = "phone_number")
    val phoneNumber: String,

    @Column(name = "hire_date")
    val hireDate: LocalDate,

    @Column(name = "salary")
    val salary: Double,

    @ManyToOne
    @JoinColumn(name = "job_id", referencedColumnName = "job_id")
    val job: Job,

    @Column(name = "commission_pct")
    val commissionPct: Double? = null,

    @Column(name = "manager_id")
    val managerId: Long? = null,

    @Column(name = "department_id")
    val departmentId: Long? = null,
)