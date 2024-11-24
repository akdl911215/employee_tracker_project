package org.jh.dto

data class FuelCostResponse(
    val fuelType: String,
    val unit: String,
    val cost: Double,
    val date: String
)