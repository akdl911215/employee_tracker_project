package org.jh.repository

import org.jh.entity.JobHistory
import org.springframework.data.jpa.repository.JpaRepository

interface JobHistoryRepository : JpaRepository<JobHistory, Long> {
    fun findAllByEmployeeId(employee_id: Long): List<JobHistory>
}