plugins {
    kotlin("jvm") version "2.0.20"
    kotlin("plugin.spring") version "2.0.20"
    kotlin("plugin.jpa") version "2.0.20"
    id("org.springframework.boot") version "3.1.0"
    id("io.spring.dependency-management") version "1.1.0"
}

tasks.register<Exec>("dockerBuild") {
    group = "docker"
    description = "Build Docker Image"
    commandLine("docker", "build", "-t", "your-dockerhub-username/your-app-name:latest", ".")
}

group = "org.jh"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.postgresql:postgresql")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("jakarta.persistence:jakarta.persistence-api:3.1.0")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:2.1.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.4")
    implementation("org.springframework.boot:spring-boot-configuration-processor")
    implementation("io.github.cdimascio:dotenv-kotlin:6.4.1")
    implementation("com.squareup.okhttp3:okhttp:4.11.0")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}

java {
    sourceCompatibility = JavaVersion.VERSION_21
    targetCompatibility = JavaVersion.VERSION_21
}