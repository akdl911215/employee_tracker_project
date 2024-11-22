package org.jh.dto

data class LocationWithDepartmentsDto (
    val locationId: Long?,
    val streetAddress: String,
    val city: String,
    val stateProvince: String?,
    val countyId: String?,
    val departments: List<DepartmentDto>
)