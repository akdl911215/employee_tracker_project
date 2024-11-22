package org.jh.entity

import jakarta.persistence.*

@Entity
@Table(name = "locations")
data class Location (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "location_id")
    val id: Long = 0,

    @Column(name = "street_address", length = 40)
    val streetAddress: String,

    @Column(name = "postal_code", length = 12)
    val postalCode: String? = null,

    @Column(name = "city", length = 30, nullable = false)
    val city: String,

    @Column(name = "state_province", length = 25)
    val stateProvince: String,

    @Column(name = "country_id", length = 2, nullable = false)
    val countryId: String? = null,

    @OneToMany(mappedBy = "location", cascade = [CascadeType.ALL], fetch = FetchType.LAZY)
    val departments: List<Department> = emptyList()
)