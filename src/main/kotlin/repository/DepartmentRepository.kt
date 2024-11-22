package org.jh.repository

import org.jh.entity.Department
import org.springframework.data.jpa.repository.JpaRepository

interface DepartmentRepository : JpaRepository<Department, Long> {
    fun findByLocationId(id: Long): List<Department>
}