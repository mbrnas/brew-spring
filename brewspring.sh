#!/bin/bash

echo "Welcome to Spring Wing - the Spring Boot project initializer!"

# Function to prompt for input with a default value
prompt_input() {
    read -p "$1 ($2): " input
    echo ${input:-$2}
}

# Function to prompt for Java version with a default value
prompt_java_version() {
    read -p "$1 (default: $2): " input
    echo ${input:-$2}
}

# URL encode function
url_encode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}

# Project Details
buildType=$(prompt_input "Enter build type [maven-project/gradle-project]" "maven-project")
groupId=$(prompt_input "Enter Group ID" "com.example")
artifactId=$(prompt_input "Enter Artifact ID" "demo")
packaging=$(prompt_input "Enter packaging type [jar/war]" "jar")
dependencies=$(prompt_input "Enter dependencies (comma-separated)" "web")
javaVersion=$(prompt_java_version "Enter Java version" "11") # Add this line

# URL encode dependencies
encodedDependencies=$(url_encode "$dependencies")

# Feedback to the user
echo "Creating a Spring Boot project with the following configurations:"
echo "Build Type: $buildType"
echo "Group ID: $groupId"
echo "Artifact ID: $artifactId"
echo "Packaging: $packaging"
echo "Dependencies: $dependencies"
echo "Java Version: $javaVersion" # Add this line

# Construct the URL with query parameters
spring_initializr_url="https://start.spring.io/starter.zip?type=$buildType&groupId=$groupId&artifactId=$artifactId&packaging=$packaging&dependencies=$encodedDependencies&language=java&javaVersion=$javaVersion"

# Use curl to download the project
curl -o "$artifactId.zip" "$spring_initializr_url"

echo "Project created: $artifactId.zip"
