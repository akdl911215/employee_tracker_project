package org.jh.service

import jakarta.persistence.EntityNotFoundException
import org.jh.dto.DepartmentDto
import org.jh.dto.LocationWithDepartmentsDto
import org.jh.repository.DepartmentRepository
import org.jh.repository.LocationRepository
import org.springframework.stereotype.Service

@Service
class LocationService (
    private val locationRepository: LocationRepository,
    private val departmentRepository: DepartmentRepository
) {
    fun getLocationWithDepartments(locationId: Long): LocationWithDepartmentsDto {
        val location = locationRepository.findById(locationId)
            ?: throw EntityNotFoundException("Location with id $locationId not found")
        val departments = departmentRepository.findByLocationId(locationId)

        return LocationWithDepartmentsDto(
            locationId = location.get().id,
            streetAddress = location.get().streetAddress,
            city = location.get().city,
            stateProvince = location.get().stateProvince,
            countyId = location.get().countryId,
            departments = departments.map {
                DepartmentDto(
                    departmentId = it.departmentId,
                    departmentName = it.departmentName,
                    managerId = it.managerId
                )
            }
        )
    }
}