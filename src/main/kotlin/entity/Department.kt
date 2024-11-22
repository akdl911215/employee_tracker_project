package org.jh.entity

import jakarta.persistence.*

@Entity
@Table(name = "departments")
data class Department(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "department_id")
    val departmentId: Long = 0,

    @Column(name = "department_name", nullable = false)
    val departmentName: String,

    @Column(name = "manager_id")
    val managerId: Long? = null,

    @ManyToOne
    @JoinColumn(name = "location_id", referencedColumnName = "location_id")
    val location: Location
)