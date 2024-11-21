package org.jh

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class HrApplication

fun main(args: Array<String>) {
    runApplication<HrApplication>(*args)
}