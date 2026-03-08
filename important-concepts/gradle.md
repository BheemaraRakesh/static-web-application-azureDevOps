# Gradle Concepts

## Overview
Gradle is a build automation tool that uses a Groovy or Kotlin-based DSL. It's highly flexible and performant, commonly used for Java, Android, and multi-language projects.

## Key Concepts

### 1. Build Scripts

#### build.gradle (Groovy)
```groovy
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0.0'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web:2.6.3'
    testImplementation 'junit:junit:4.13.2'
}

application {
    mainClass = 'com.example.App'
}
```

#### build.gradle.kts (Kotlin)
```kotlin
plugins {
    java
    application
}

group = "com.example"
version = "1.0.0"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web:2.6.3")
    testImplementation("junit:junit:4.13.2")
}

application {
    mainClass.set("com.example.App")
}
```

### 2. Project Structure

#### Standard Layout
```
project/
├── build.gradle
├── settings.gradle
├── gradle/
│   └── wrapper/
├── src/
│   ├── main/
│   │   ├── java/
│   │   ├── resources/
│   │   └── kotlin/
│   └── test/
│       ├── java/
│       └── resources/
└── build/
```

### 3. Tasks

#### Built-in Tasks
- **build:** Assembles and tests project
- **clean:** Deletes build directory
- **test:** Runs tests
- **jar:** Assembles JAR archive
- **run:** Runs the application

#### Custom Tasks
```groovy
task hello {
    doLast {
        println 'Hello, Gradle!'
    }
}

task deploy(dependsOn: build) {
    doLast {
        println 'Deploying application...'
    }
}
```

### 4. Plugins

#### Core Plugins
- **java:** Basic Java support
- **application:** Application execution
- **war:** Web application archive
- **kotlin:** Kotlin language support

#### Community Plugins
- **spring-boot:** Spring Boot support
- **shadow:** Fat JAR creation
- **jacoco:** Code coverage
- **checkstyle:** Code style checking

**Example:**
```groovy
plugins {
    id 'java'
    id 'jacoco'
    id 'checkstyle'
}

jacocoTestReport {
    reports {
        xml.enabled true
        html.enabled true
    }
}

checkstyle {
    toolVersion = '8.45.1'
}
```

### 5. Dependencies

#### Configuration Types
- **implementation:** Compile and runtime (not exposed to consumers)
- **api:** Compile and runtime (exposed to consumers)
- **compileOnly:** Compile time only
- **runtimeOnly:** Runtime only
- **testImplementation:** Test dependencies

#### Version Management
```groovy
dependencies {
    implementation 'com.google.guava:guava:31.0.1-jre'
    testImplementation 'junit:junit:4.13.2'
}

configurations.all {
    resolutionStrategy {
        force 'com.google.guava:guava:31.0.1-jre'
    }
}
```

### 6. Multi-Project Builds

#### settings.gradle
```groovy
rootProject.name = 'multi-project'
include 'api', 'web', 'service'
```

#### Project Structure
```
multi-project/
├── settings.gradle
├── build.gradle
├── api/
│   └── build.gradle
├── web/
│   └── build.gradle
└── service/
    └── build.gradle
```

#### Root build.gradle
```groovy
allprojects {
    group = 'com.example'
    version = '1.0.0'
    
    repositories {
        mavenCentral()
    }
}

subprojects {
    apply plugin: 'java'
    
    dependencies {
        testImplementation 'junit:junit:4.13.2'
    }
}
```

### 7. Build Variants

#### Source Sets
```groovy
sourceSets {
    main {
        java {
            srcDirs = ['src/main/java']
        }
    }
    test {
        java {
            srcDirs = ['src/test/java']
        }
    }
    integrationTest {
        java {
            srcDirs = ['src/integrationTest/java']
        }
    }
}
```

### 8. Gradle Wrapper

#### Purpose
Ensures consistent Gradle version across environments.

#### Generation
```bash
gradle wrapper --gradle-version 7.4
```

#### Files Created
- gradlew (Unix script)
- gradlew.bat (Windows script)
- gradle/wrapper/gradle-wrapper.properties
- gradle/wrapper/gradle-wrapper.jar

### 9. Testing

#### Test Configuration
```groovy
test {
    useJUnitPlatform()
    
    testLogging {
        events "passed", "skipped", "failed"
    }
    
    reports {
        html.enabled = true
    }
}
```

#### Integration Tests
```groovy
task integrationTest(type: Test) {
    useJUnitPlatform()
    testClassesDirs = sourceSets.integrationTest.output.classesDirs
    classpath = sourceSets.integrationTest.runtimeClasspath
}
```

### 10. Publishing

#### Maven Publish Plugin
```groovy
plugins {
    id 'maven-publish'
}

publishing {
    publications {
        maven(MavenPublication) {
            from components.java
        }
    }
    
    repositories {
        maven {
            url = uri("${buildDir}/repo")
        }
    }
}
```

## Real Project Examples

### Spring Boot Application
```groovy
plugins {
    id 'org.springframework.boot' version '2.6.3'
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
    id 'java'
}

group = 'com.example'
version = '1.0.0'
sourceCompatibility = '11'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    runtimeOnly 'com.h2database:h2'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}
```

### Android Application
```groovy
plugins {
    id 'com.android.application'
    id 'kotlin-android'
}

android {
    compileSdk 31
    
    defaultConfig {
        applicationId "com.example.myapp"
        minSdk 21
        targetSdk 31
        versionCode 1
        versionName "1.0"
        
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
    
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = '1.8'
    }
}

dependencies {
    implementation 'androidx.core:core-ktx:1.7.0'
    implementation 'androidx.appcompat:appcompat:1.4.1'
    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.3'
}
```

### Multi-Project with Custom Plugin
```groovy
// buildSrc/src/main/groovy/com.example.greeting.gradle
class GreetingPlugin implements Plugin<Project> {
    void apply(Project project) {
        project.task('greet') {
            doLast {
                println 'Hello from custom plugin!'
            }
        }
    }
}

// settings.gradle
include 'app'

// app/build.gradle
plugins {
    id 'com.example.greeting'
}

apply plugin: GreetingPlugin

task buildAndGreet {
    dependsOn build, greet
}
```

### Performance Optimization
```groovy
// gradle.properties
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.configureondemand=true
org.gradle.daemon=true

// build.gradle
tasks.withType(JavaCompile) {
    options.compilerArgs << '-Xlint:unchecked'
    options.incremental = true
}

tasks.withType(Test) {
    maxParallelForks = Runtime.runtime.availableProcessors()
}
```

## Best Practices
- Use Gradle Wrapper for version consistency
- Leverage build cache for faster builds
- Use parallel execution for multi-project builds
- Implement proper dependency management
- Use plugins for common functionality
- Configure CI/CD integration
- Implement proper testing strategies
- Use source sets for different test types
- Optimize build performance
- Document custom tasks and plugins